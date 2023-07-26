//
//  MeetView.swift
//  Hot Prospects
//
//  Created by Radu Petrisel on 25.07.2023.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var email = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title)
                    
                    TextField("Email Address", text: $email)
                        .textContentType(.emailAddress)
                        .font(.title)
                }
                
                Section("QR Code") {
                    HStack {
                        Spacer()
                        
                        Image(uiImage: qrCode)
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .contextMenu {
                                Button {
                                    let imageSaver = ImageSaver()
                                    imageSaver.save(image: qrCode)
                                } label: {
                                    Label("Save QR code", systemImage: "square.and.arrow.down")
                                }
                            }
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle("Your code")
            .onAppear { updateQR() }
            .onChange(of: name) { _ in updateQR() }
            .onChange(of: email) { _ in updateQR() }
        }
    }
    
    private func updateQR() {
        qrCode = generateQRCode(from: "\(name)\n\(email)")
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
