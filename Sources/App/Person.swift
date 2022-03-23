//
//  Person.swift
//  
//
//  Created by Danylo Litvinchuk on 15.11.2021.
//

import Vapor

struct Person: Content, Comparable, Codable {
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return phase(person: lhs) > phase(person: rhs)
    }
    
    let name: String
    let age: Int
    let occupation: Occupation
    let hasChronicalIllness: Bool
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case age = "age"
        case occupation = "occupation"
        case hasChronicalIllness = "has_chronical_illness"
    }
}

func phase(person: Person) -> Int {
    let occupationIndex = Occupation.index(occupation: person.occupation)
    let ageIndex = agePhase(person: person)
    let illnessIndex: Int
    if person.hasChronicalIllness {
        illnessIndex = 4
    } else {
        illnessIndex = 0
    }
    
    if ageIndex != 0 {
        return occupationIndex < ageIndex ? occupationIndex : ageIndex
    }
    
    if illnessIndex != 0 {
        return occupationIndex < illnessIndex ? occupationIndex : illnessIndex
    }
    
    return occupationIndex
}

func agePhase(person: Person) -> Int {
    let phase2Age = (80...)
    let phase3Age = (65 - 79)
    let phase4Age = (60 - 64)
    
    switch person.age {
    case phase2Age:
        return 2
    case phase3Age:
        return 3
    case phase4Age:
        return 4
    default:
        return 0
    }
}

enum Occupation: String, Codable {
    
    static func index(occupation: Occupation) -> Int {
        let prior: [Occupation: Int] = [.medWorkerCovid: 1, .elderlyWorker: 1, .soldiersAtWar: 1, .medWorker: 2, .socialWorkers: 2,
            .criticalSecurityService: 3, .education: 3,
            .prisonWorker: 4, .prisoner: 4, .other: 5]
        guard let index = prior[occupation] else { return 0 }
        return index
    }
    
    case medWorkerCovid = "med_worker_covid"
    case elderlyWorker = "elderly_worker"
    case soldiersAtWar = "soldiers_at_war"
    case socialWorkers = "social_workers"
    case medWorker = "med_worker"
    case criticalSecurityService = "critical_security_service"
    case education = "education"
    case prisonWorker = "prison_worker"
    case prisoner = "prisoner"
    case other = "other"
}
