//
//  CameraScreen.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 11/05/25.
//

import SwiftUI
import RealityKit
import ARKit
import AVFoundation
import DotLottie

class ARImageData: ObservableObject {
    @Published var detectedImageName: String? = nil
}

struct CameraView: View {
    @Environment(\.navigation) private var navigation
    @StateObject private var arImageData = ARImageData()
    
    var body: some View {
        ZStack {
            ARViewContainer(arImageData: arImageData, onSuccess: { data in
                navigation.path.append(NavigationModel(destination: "Success", data: data))
            })
            
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.black.opacity(0.5))
                    
                    HStack {
                        Rectangle()
                            .fill(Color.black.opacity(0.5))
                            .frame(width: 20)
                        
                        DotLottieAnimation(
                            webURL: "https://lottie.host/c59dc8a7-e2dd-444f-9562-6596d1a4c594/YNB3pQCYgh.lottie", config: AnimationConfig(autoplay: true, loop: true)
                        ).view()
                        
                        Rectangle()
                            .fill(Color.black.opacity(0.5))
                            .frame(width: 20)
                    }
                    .frame(height: geometry.size.height*0.5)
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.5))
                }
            }
        }
        .navigationTitle(Text("Camera"))
        
    }
}

/* UIViewRepresentable is a protocol in SwiftUI that allows you to wrap a UIKit view (like UITextField, UIScrollView, MKMapView, ARView, etc.) so you can use it inside SwiftUI. SwiftUI doesn’t natively support all UIKit components yet. So, if you want to use a UIKit view that’s not available or easily customizable in SwiftUI, you can bridge it with UIViewRepresentable. */
struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var arImageData: ARImageData
    var onSuccess: ((AcademyMateModel) -> Void)
    
    // Create and return the UIKit view
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Set up the AR session
        let config = ARImageTrackingConfiguration()
        if let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "ID Card", bundle: nil) {
            config.trackingImages = referenceImages
            config.maximumNumberOfTrackedImages = 1
            arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
        }
        
        // Set the delegate
        arView.session.delegate = context.coordinator
        
        // Pass the ARView to the delegate
        context.coordinator.arView = arView
        
        return arView
    }
    
    // Update the view with new data from SwiftUI
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    /* Used when you need to manage communication between your SwiftUI view and UIKit view, especially when the UIKit view uses delegates, target-action, or data sources. SwiftUI is declarative and reactive, while UIKit often uses delegates and callbacks. The Coordinator serves as a bridge to handle those imperative UIKit patterns. */
    func makeCoordinator() -> ARSessionCoordinator {
        return ARSessionCoordinator(arImageData: arImageData, onSuccess: onSuccess)
    }
}

// The ARSessionDelegate protocol is used to receive updates about the AR session.
class ARSessionCoordinator: NSObject, ARSessionDelegate {
    weak var arView: ARView?
    var arImageData: ARImageData
    var onSuccess: ((AcademyMateModel) -> Void)
    
    init(arImageData: ARImageData, onSuccess: @escaping ((AcademyMateModel) -> Void)) {
        self.arImageData = arImageData
        self.onSuccess = onSuccess
    }
    
    // Called when new AR anchors (like a plane or 3D object or Detected ARImageAnchor) are added to the session. Called on a background thread, not the main thread
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // An ARAnchor defines a point of interest in the real world that ARKit can track, and it is used to attach virtual content in a specific position relative to the real world.
        for anchor in anchors {
            guard let imageAnchor = anchor as? ARImageAnchor,
                  let name = imageAnchor.referenceImage.name else { continue }
            
            arImageData.detectedImageName = name
            
            DispatchQueue.main.async {
                if let data = academyMateData.first(where: { $0.name == name }) {
                    self.onSuccess(data)
                }
            }
        }
    }
}
