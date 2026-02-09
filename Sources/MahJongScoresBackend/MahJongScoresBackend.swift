import Vapor
import OpenAPIRuntime
import OpenAPIVapor

@main
struct MahJongScoresBackend {
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

        app.logger.info("Server configured and ready to accept connections on port 8080")
    }
}
