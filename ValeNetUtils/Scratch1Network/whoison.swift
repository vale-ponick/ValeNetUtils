//
//  whoison.swift
//  ValeNetUtils
//
//  Created by Валерия Пономарева on 28.05.2026.
//

import Foundation

func runWhoison() {
    print("👥 WhoIsOn: активные пользователи в системе")
    
    let process = Process()
    let pipe = Pipe()
    
    process.executableURL = URL(fileURLWithPath: "/usr/bin/who")
    process.standardOutput = pipe
    
    do {
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        
        let lines = output.split(separator: "\n")
        
        if lines.isEmpty {
            print("❌ Нет активных пользователей")
        } else {
            print("👥 Активных пользователей: \(lines.count)")
            for line in lines {
                let parts = line.split(separator: " ")
                if let user = parts.first {
                    print("   - \(user)")
                }
            }
        }
    } catch {
        print("❌ Ошибка: \(error)")
    }
}
