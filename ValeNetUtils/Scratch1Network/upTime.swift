//
//  upTime.swift
//  ValeNetUtils
//
//  Created by Валерия Пономарева on 27.05.2026.
//

import Foundation

func runUpTime() {
    print("🕐 Uptime: время работы компьютера")
    
    let process = Process()
    let pipe = Pipe()
    
    process.executableURL = URL(fileURLWithPath: "/usr/bin/uptime")
    process.standardOutput = pipe
    
    do {
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        
        // Парсим: ищем "up" и берем до "user"
        if let upRange = output.range(of: "up "),
           let userRange = output.range(of: " user") {
            let uptimeString = output[upRange.upperBound..<userRange.lowerBound]
            print("🕐 Компьютер работает: \(uptimeString)")
        } else {
            print("❌ Не удалось определить время работы")
        }
    } catch {
        print("❌ Ошибка: \(error)")
    }
}
