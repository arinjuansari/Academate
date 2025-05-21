//
//  Counter.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 15/05/25.
//

import Combine
import WatchConnectivity

final class UserDataProvider: ObservableObject {
    var session: WCSession
    let delegate: WCSessionDelegate
    let subject = PassthroughSubject<[String], Never>()
    
    @Published private(set) var connections: [String] = []
    
    init(session: WCSession = .default) {
        self.delegate = SessionDelegater(connectionsSubject: subject)
        self.session = session
        self.session.delegate = self.delegate
        self.session.activate()
        
        subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$connections)
    }
    
    func sendUserData(connections: [String]) {
        self.connections = connections
        session.sendMessage(["connections": connections], replyHandler: nil) { error in
            print("error sending data: \(error.localizedDescription)")
        }
    }
}
