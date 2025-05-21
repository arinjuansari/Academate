//
//  LeaderboradData.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 11/05/25.
//

import Foundation

let leaderboardData: [LeaderboardModel] = [
    LeaderboardModel(id: 1, minConnect: 0, maxConnect: 1, title: "The Deep Diver", personality: "(Strong Introvert)", quotes: "“Below the surface, I find peace.”", image: "img-deep-diver", colorButton: academateColors.navy),
    LeaderboardModel(id: 2, minConnect: 1, maxConnect: 2, title: "The Lighthouse Keeper", personality: "(Mild Introvert)", quotes: "“I shine best from afar.”", image: "img-lighthouse-keeper", colorButton: academateColors.tealDark),
    LeaderboardModel(id: 3, minConnect: 2, maxConnect: 3, title: "The Compass Bearer", personality: "(Ambivert)", quotes: "“Where the wind goes, I follow.”", image: "img-compass-bearer", colorButton: academateColors.tealLight),
    LeaderboardModel(id: 4, minConnect: 3, maxConnect: 4, title: "The Deckhand Leader", personality: "(Mild Extrovert)", quotes: "“Guided by connection, anchored by peace.”", image: "img-deckhand-leader", colorButton: academateColors.yellowBright),
    LeaderboardModel(id: 5, minConnect: 4, maxConnect: 100, title: "The Captain of the Crowd", personality: "(Strong Extrovert)", quotes: "“Full speed ahead, with everyone on board!”", image: "img-captain-crowd", colorButton: academateColors.redDeep),
]
