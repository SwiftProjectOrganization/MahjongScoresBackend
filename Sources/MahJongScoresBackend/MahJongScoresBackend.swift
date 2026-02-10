import SwiftUI
import Vapor
import OpenAPIRuntime
import OpenAPIVapor

@main
struct MahJongScoresBackend {
  
  @AppStorage("dirName") private var dirName = "MahjongScore"
  @AppStorage("serverPath") private var serverPath = "http://Rob-Travel-M5.local:8080/"

    static func main() async throws {
        let app = try await Application.make(.detect())

        do {
            try await configure(app)
            try await app.execute()
        } catch {
            app.logger.error("Fatal error: \(error)")
            try? await app.asyncShutdown()
            throw error
        }
    }

    static func configure(_ app: Application) async throws {
        // Configure server to listen on all network interfaces
        app.http.server.configuration.hostname = "0.0.0.0"
        app.http.server.configuration.port = 8081
        
        // Configure CORS
        let corsConfiguration = CORSMiddleware.Configuration(
            allowedOrigin: .all,
            allowedMethods: [.GET, .POST, .PUT, .DELETE, .OPTIONS],
            allowedHeaders: [.accept, .authorization, .contentType, .origin]
        )
        let cors = CORSMiddleware(configuration: corsConfiguration)
        app.middleware.use(cors)

        // Create the API handler
        let handler = TournamentAPIHandler()

        // Register OpenAPI routes
        let transport = VaporTransport(routesBuilder: app)
        try handler.registerHandlers(on: transport, serverURL: URL(string: "/")!)

        app.logger.info("Server configured and ready to accept connections on port 8081")
    }
}
