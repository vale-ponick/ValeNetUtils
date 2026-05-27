//
//  diskFree.swift
//  ValeNetUtils
//
//  Created by Валерия Пономарева on 27.05.2026.
//

import Foundation

func runDiskFree() {
    
    print("DiskFree: Показывает свободное место на диске в читаемом формате")
    
    let arguments = CommandLine.arguments // это массив строк -> получаем аргументы командной строки
    
    guard arguments.count > 2 else {
        print("❌ Show a path: diskfree /")
        exit(1)
    }
    let discPath = arguments[2]
    
    let process = Process()
    let pipe = Pipe()
    
    process.executableURL = URL(fileURLWithPath: "/bin/df")
    process.arguments = ["-h", discPath]
    process.standardOutput = pipe
    process.standardError = pipe
    
    do {
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        
        if output.contains("No such file") {
            print("❌ Puth not exist")
        } else {
            let lines = output.split(separator: "\n")
            
            if lines.count > 1 {
                let dataLine = lines[1]
                let columns = dataLine.split(separator: " ")
                
                if columns.count > 3 {
                    let available = columns[3]
                    print("✅ \(discPath): \(available) free")
                }
            }
        }
        
    } catch {
        print("Error: \(error)")
    }
}
// DiskFree: Показывает свободное место на диске в читаемом формате
// ❌ Puth not exist
    
 /* написала полезную утилиту, которая:
    1 .Проверяет аргументы
    2. Запускает системную команду
    3. Парсит вывод
    4. Обрабатывает ошибки
    5. Выводит красивый результат */
