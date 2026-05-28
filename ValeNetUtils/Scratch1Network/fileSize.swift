//
//  fileSize.swift
//  ValeNetUtils
//
//  Created by Валерия Пономарева on 28.05.2026.
//

import Foundation

func runFilesize() {
    print("📦 FileSize: показывает размер файла")
    
    let arguments = CommandLine.arguments
    
    guard arguments.count > 2 else {
        print("❌ Укажите путь к файлу: filesize /путь/к/файлу")
        exit(1)
    }
    
    let filePath = arguments[2]
    
    let process = Process()
    let pipe = Pipe()
    
    process.executableURL = URL(fileURLWithPath: "/bin/ls")
    process.arguments = ["-lh", filePath]
    process.standardOutput = pipe
    
    do {
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        
        if output.contains("No such file") {
            print("❌ Файл не найден: \(filePath)")
        } else {
            let parts = output.split(separator: " ")
            // ls -lh вывод: -rw-r--r-- 1 user staff 1.2K date time filename
            if parts.count >= 5 {
                let size = parts[4]
                print("📦 \(filePath): \(size)")
            }
        }
    } catch {
        print("❌ Ошибка: \(error)")
    }
}
