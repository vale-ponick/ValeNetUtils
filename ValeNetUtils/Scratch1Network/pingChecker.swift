//
//  pingChecker.swift
//  ValeNetUtils
//
//  Created by Валерия Пономарева on 27.05.2026.
//

import Foundation

func runPingChecker() {
    print("🏓 PingChecker: проверка доступности хоста")
    
    let arguments = CommandLine.arguments
    
    guard arguments.count > 2 else {
        print("❌ Укажите хост: pingchecker google.com")
        exit(1)
    }
    
    let host = arguments[2]
    print("Проверяем: \(host)")
    
    let process = Process()
    let pipe = Pipe()
    
    process.executableURL = URL(fileURLWithPath: "/sbin/ping")
    process.arguments = ["-c", "3", "-t", "3", host]
    process.standardOutput = pipe
    process.standardError = pipe
    
    do {
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        
        if output.contains("time=") {
            print("✅ \(host) доступен")
        } else {
            print("❌ \(host) не отвечает")
        }
    } catch {
        print("❌ Ошибка: \(error)")
    }
}
