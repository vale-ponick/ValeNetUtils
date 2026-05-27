//
//  processList.swift
//  ValeNetUtils
//
//  Created by Валерия Пономарева on 27.05.2026.
//

import Foundation

func runProcessList() {
    
    
    print("🚀 ProcessList: Показывает количество процессов, запущенных от имени пользователя")
    
    let arguments = CommandLine.arguments
    
    var username: String
    
    // Определяем имя пользователя
    if arguments.count > 2 {
        username = arguments[2]
    } else {
        let whoamiProcess = Process()
        let whoamiPipe = Pipe()
        
        whoamiProcess.executableURL = URL(fileURLWithPath: "/usr/bin/whoami")
        whoamiProcess.standardOutput = whoamiPipe
        
        try? whoamiProcess.run()
        whoamiProcess.waitUntilExit()
        
        let data = whoamiPipe.fileHandleForReading.readDataToEndOfFile()
        username = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    print("User: \(username)")
    
    // Считаем процессы пользователя
    let psProcess = Process()
    let psPipe = Pipe()
    
    psProcess.executableURL = URL(fileURLWithPath: "/bin/zsh")
    psProcess.arguments = ["-c", "ps -u \(username) | tail -n +2 | wc -l"]
    psProcess.standardOutput = psPipe
    
    do {
        try psProcess.run()
        psProcess.waitUntilExit()
        
        let data = psPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        let count = output.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("✅ У пользователя \(username): \(count) процессов")
        
    } catch {
        print("❌ Ошибка при запуске ps: \(error)")
    }
}
