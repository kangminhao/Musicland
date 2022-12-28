//
//  PlaybackFullscreenView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/27/21.
//

import SwiftUI

struct PlaybackFullscreenView: View {
    
    var animation: Namespace.ID
    
    @EnvironmentObject var model: Model
    
    @State var disclosureExpanded = false
    @State var playlistSheetPresented = false
    
    @State var isRepeat = false
    
    var body: some View {
        if let currentSong = model.currentSong {
            
            let artwork = model.uiImage
                
                VStack {
                    
                    Image(uiImage: artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .matchedGeometryEffect(id: (currentSong.title ?? "") + "art", in: animation)
                        .padding()
                        .padding(.top, 40)
                        .scaleEffect(model.isPlaying ? 1.0 : 0.5)
                        .shadow(color: Color.black.opacity(model.isPlaying ? 0.2 : 0.0), radius: 30, x: 0, y: 60)
                        .onTapGesture {
                            Haptics.hit()
                        }
                    
                    
                    Menu {
                        Button(action: {
                            playlistSheetPresented.toggle()
                        }, label: {
                            Text("Add to Playlist")
                        })
                    } label: {
                        VStack(spacing: 8) {
                            Text(currentSong.title ?? "NA")
                                .foregroundColor(.white)
                                .font(Font.system(.title2).bold())
                            
                            Text(currentSong.artist ?? "NA")
                                .foregroundColor(.white.opacity(0.5))
                                .foregroundColor(.secondary)
                                .font(Font.system(.title3).bold())
                            
                            Text("Tap to add to Library/Playlist")
                                .font(.caption2)
                        }
                        .matchedGeometryEffect(id: (currentSong.title ?? "") + "details", in: animation, properties: .position)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                    
                    Spacer(minLength: 0)
                    
                    ProgessView()
                        .padding(.horizontal)
                    
                    Spacer(minLength: 0)
                    
                    VStack {
                        HStack(spacing: 0) {
                            Image(systemName: "repeat")
                                .font(.largeTitle)
                                .font(.system(size: 45))
                                .multilineTextAlignment(.center)
                                .foregroundColor(isRepeat ? .blue : .white)
                                .onTapGesture {
                                    if isRepeat {
                                        model.musicPlayer.repeatMode = .none
                                    } else {
                                        model.musicPlayer.repeatMode = .one
                                    }
                                    isRepeat.toggle()
                                }
                            
                            Image(systemName: "gobackward.15")
                                .font(.largeTitle)
                                .font(.system(size: 45))
                                .padding(.leading, 30)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    model.musicPlayer.currentPlaybackTime -= 15
                                }
                            
                            PlayPauseButton()
                                .environmentObject(model)
                                .matchedGeometryEffect(id: (currentSong.title ?? "") + "play_button", in: animation)
                                .font(.system(size: 50))
                                .padding(.horizontal, 30)
                                .multilineTextAlignment(.center)
                            
                            Image(systemName: "goforward.15")
                                .font(.largeTitle)
                                .font(.system(size: 45))
                                .padding(.trailing, 30)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    model.musicPlayer.currentPlaybackTime += 15
                                }
                            
                            Image(systemName: "stop.fill")
                                .font(.largeTitle)
                                .font(.system(size: 45))
                                .onTapGesture {
                                    model.musicPlayer.skipToBeginning()
                                    model.musicPlayer.stop()
                                }
                            
                            
                        }
                        
                        AirplayView()
                            .frame(width: 50, height: 50)
                        
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 40)

                Spacer(minLength: 0)
            }
            .padding()
            .background(
                withAnimation(.easeOut) {
                    Rectangle()
                        .foregroundColor(Color(artwork.averageColor ?? .gray))
                        .saturation(0.5)
                        .matchedGeometryEffect(id: (currentSong.title ?? "") + "frame", in: animation)
                }
                
            )
            .accentColor(Color(artwork.originalAverageColor ?? .systemPink))
            .onAppear {
                hideKeyboard()
            }
        }
    }
}

extension UIImage {
    /// Average color of the image, nil if it cannot be found
    var averageColor: UIColor? {
        // convert our image to a Core Image Image
        guard let inputImage = CIImage(image: self) else { return nil }

        // Create an extent vector (a frame with width and height of our current input image)
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)

        // create a CIAreaAverage filter, this will allow us to pull the average color from the image later on
        guard let filter = CIFilter(name: "CIAreaAverage",
                                  parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        // A bitmap consisting of (r, g, b, a) value
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])

        // Render our output image into a 1 by 1 image supplying it our bitmap to update the values of (i.e the rgba of the 1 by 1 image will fill out bitmap array
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

        // Convert our bitmap images of r, g, b, a to a UIColor
        return UIColor(red: CGFloat(bitmap[0]) * 0.6 / 255,
                       green: CGFloat(bitmap[1]) * 0.6 / 255,
                       blue: CGFloat(bitmap[2]) * 0.6 / 255,
                       alpha: CGFloat(bitmap[3]) / 255)
    }
    
    var originalAverageColor: UIColor? {
        // convert our image to a Core Image Image
        guard let inputImage = CIImage(image: self) else { return nil }

        // Create an extent vector (a frame with width and height of our current input image)
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)

        // create a CIAreaAverage filter, this will allow us to pull the average color from the image later on
        guard let filter = CIFilter(name: "CIAreaAverage",
                                  parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        // A bitmap consisting of (r, g, b, a) value
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])

        // Render our output image into a 1 by 1 image supplying it our bitmap to update the values of (i.e the rgba of the 1 by 1 image will fill out bitmap array
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

        // Convert our bitmap images of r, g, b, a to a UIColor
        return UIColor(red: CGFloat(bitmap[0]) / 255,
                       green: CGFloat(bitmap[1]) / 255,
                       blue: CGFloat(bitmap[2]) / 255,
                       alpha: CGFloat(bitmap[3]) / 255)
    }
}
