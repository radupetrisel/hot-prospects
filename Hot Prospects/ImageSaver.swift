//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Radu Petrisel on 18.07.2023.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    init(successHandler: (() -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        self.successHandler = successHandler
        self.errorHandler = errorHandler
    }
    
    func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(onComplete(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func onComplete(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
