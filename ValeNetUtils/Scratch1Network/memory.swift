//
//  memory.swift
//  ValeNetUtils
//
//  Created by Валерия Пономарева on 28.05.2026.
//

import Foundation

func runMemory() {
    print("💾 Memory: свободная оперативная память")
    
    let process = Process()
    let pipe = Pipe()
    
    process.executableURL = URL(fileURLWithPath: "/usr/bin/vm_stat")
    process.standardOutput = pipe
    
    do {
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        
        let lines = output.split(separator: "\n")
        var freePages: Double = 0
        let pageSize: Double = 4096 // байт на страницу (обычно)
        
        for line in lines {
            if line.contains("Pages free:") {
                let parts = line.split(separator: ":")
                if parts.count > 1 {
                    let value = parts[1].trimmingCharacters(in: .whitespaces)
                    freePages = Double(value) ?? 0
                }
            }
        }
        
        let freeMB = (freePages * pageSize) / 1024 / 1024
        print("💾 Свободно: \(Int(freeMB)) MB")
        
    } catch {
        print("❌ Ошибка: \(error)")
    }
}
