//
//  Session.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 15/05/25.
//

import Combine
import WatchConnectivity

class SessionDelegater: NSObject, WCSessionDelegate {
    let connectionsSubject: PassthroughSubject<[String], Never>
    
    init(connectionsSubject: PassthroughSubject<[String], Never>) {
        self.connectionsSubject = connectionsSubject
        super.init()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Protocol comformance only
        // Not needed for this demo
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            if let connections = message["connections"] as? [String] {
                self.connectionsSubject.send(connections)
            } else {
                print("There was an error")
            }
        }
    }
    
    // iOS Protocol comformance
    // Not needed for this demo otherwise
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif
}
