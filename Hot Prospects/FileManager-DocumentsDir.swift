//
//  FileManager-DocumentsDir.swift
//  Hot Prospects
//
//  Created by Radu Petrisel on 26.07.2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        Self.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
