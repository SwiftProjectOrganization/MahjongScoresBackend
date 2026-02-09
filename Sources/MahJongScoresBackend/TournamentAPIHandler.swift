import Foundation
import OpenAPIRuntime
import HTTPTypes

// File-based storage for tournaments in user's Documents/MahJongScore directory
actor TournamentStorage {
    private var tournaments: [Components.Schemas.Tournament] = []
    private let storageDirectory: URL
    private let tournamentsFile: URL
    
    init() {
        // Get user's Documents directory
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Create MahJongScore subdirectory
        self.storageDirectory = documentsURL.appendingPathComponent("MahJongScore")
        self.tournamentsFile = storageDirectory.appendingPathComponent("tournaments.json")
        
        // Create directory if it doesn't exist
        try? fileManager.createDirectory(at: storageDirectory, withIntermediateDirectories: true)
        
        // Load existing tournaments synchronously during initialization
        if fileManager.fileExists(atPath: tournamentsFile.path) {
            do {
                let data = try Data(contentsOf: tournamentsFile)
                let decoder = JSONDecoder()
                self.tournaments = try decoder.decode([Components.Schemas.Tournament].self, from: data)
            } catch {
                print("Error loading tournaments: \(error)")
                self.tournaments = []
            }
        } else {
            self.tournaments = []
        }
    }
    
    private func saveTournaments() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let data = try encoder.encode(tournaments)
            try data.write(to: tournamentsFile, options: .atomic)
        } catch {
            print("Error saving tournaments: \(error)")
        }
    }
    
    func list() -> [Components.Schemas.Tournament] {
        return tournaments
    }
    
    func get(id: UUID) -> Components.Schemas.Tournament? {
        return tournaments.first { UUID(uuidString: $0.id) == id }
    }
    
    func create(_ tournament: Components.Schemas.Tournament) -> Components.Schemas.Tournament {
        var newTournament = tournament
        if newTournament.id.isEmpty {
            newTournament.id = UUID().uuidString
        }
        tournaments.append(newTournament)
        saveTournaments()
        return newTournament
    }
    
    func update(id: UUID, tournament: Components.Schemas.Tournament) -> Components.Schemas.Tournament? {
        guard let index = tournaments.firstIndex(where: { UUID(uuidString: $0.id) == id }) else {
            return nil
        }
        var updatedTournament = tournament
        updatedTournament.id = id.uuidString
        tournaments[index] = updatedTournament
        saveTournaments()
        return updatedTournament
    }
    
    func delete(id: UUID) -> Bool {
        guard let index = tournaments.firstIndex(where: { UUID(uuidString: $0.id) == id }) else {
            return false
        }
        tournaments.remove(at: index)
        saveTournaments()
        return true
    }
}

struct TournamentAPIHandler: APIProtocol {
    let storage = TournamentStorage()
    
    // GET /tournaments
    func listTournaments(_ input: Operations.listTournaments.Input) async throws -> Operations.listTournaments.Output {
        let tournaments = await storage.list()
        return .ok(.init(body: .json(tournaments)))
    }
    
    // POST /tournaments
    func createTournament(_ input: Operations.createTournament.Input) async throws -> Operations.createTournament.Output {
        switch input.body {
        case .json(let tournament):
            let created = await storage.create(tournament)
            return .created(.init(body: .json(created)))
        }
    }
    
    // GET /tournaments/{tournamentId}
    func getTournament(_ input: Operations.getTournament.Input) async throws -> Operations.getTournament.Output {
        guard let id = UUID(uuidString: input.path.tournamentId) else {
            return .notFound(.init())
        }
        
        guard let tournament = await storage.get(id: id) else {
            return .notFound(.init())
        }
        
        return .ok(.init(body: .json(tournament)))
    }
    
    // PUT /tournaments/{tournamentId}
    func updateTournament(_ input: Operations.updateTournament.Input) async throws -> Operations.updateTournament.Output {
        guard let id = UUID(uuidString: input.path.tournamentId) else {
            return .notFound(.init())
        }
        
        switch input.body {
        case .json(let tournament):
            guard let updated = await storage.update(id: id, tournament: tournament) else {
                return .notFound(.init())
            }
            return .ok(.init(body: .json(updated)))
        }
    }
    
    // DELETE /tournaments/{tournamentId}
    func deleteTournament(_ input: Operations.deleteTournament.Input) async throws -> Operations.deleteTournament.Output {
        guard let id = UUID(uuidString: input.path.tournamentId) else {
            return .notFound(.init())
        }
        
        let success = await storage.delete(id: id)
        return success ? .noContent(.init()) : .notFound(.init())
    }
}
