# MahJong Scores Backend

A Vapor-based backend server for the MahJong Scores iOS application, using SwiftOpenAPI for type-safe API implementation.

## Features

- RESTful API for tournament management
- SwiftOpenAPI-generated types and routes from OpenAPI specification
- In-memory storage (can be replaced with a database)
- CORS enabled for development

## Requirements

- Swift 6.2 or later
- macOS 14.0 or later

## Setup

1. Navigate to the backend directory:
```bash
cd /Users/rob/Projects/Swift/Apps/MahJongScoresBackend
```

2. Resolve dependencies:
```bash
swift package resolve
```

3. Build the project:
```bash
swift build
```

## Running the Server

Start the server with:
```bash
swift run
```

The server will start on `http://localhost:8080`

## API Endpoints

### List all tournaments
```
GET /tournaments
```

### Create a new tournament
```
POST /tournaments
Content-Type: application/json

{
  "id": "uuid-string",
  "scheduleItem": 0,
  "ruleSet": "INTERNATIONAL",
  "fpName": "Player 1",
  "spName": "Player 2",
  ...
}
```

### Get a specific tournament
```
GET /tournaments/{tournamentId}
```

### Update a tournament
```
PUT /tournaments/{tournamentId}
Content-Type: application/json

{
  "id": "uuid-string",
  ...
}
```

### Delete a tournament
```
DELETE /tournaments/{tournamentId}
```

## Development

The API is defined in `Sources/MahJongScoresBackend/openapi.yaml`. When you modify this file:

1. The SwiftOpenAPI generator plugin will automatically regenerate types and protocol
2. Update the `TournamentAPIHandler.swift` to implement any new endpoints
3. Rebuild the project

## iOS App Integration

The iOS app includes:
- `TournamentDTO.swift` - Codable transfer objects for JSON serialization
- `TournamentAPIService.swift` - API client for communicating with the backend
- `SyncTournamentView.swift` - UI for uploading tournaments to the server

To sync tournaments from the iOS app:
1. Open the app
2. Tap the sync button in the toolbar
3. Configure the server URL (default: http://localhost:8080)
4. Select tournaments to upload
5. Tap "Upload"

## Project Structure

```
MahJongScoresBackend/
├── Package.swift                          # Swift package manifest
├── Sources/
│   └── MahJongScoresBackend/
│       ├── MahJongScoresBackend.swift     # Main application entry point
│       ├── TournamentAPIHandler.swift     # API implementation
│       ├── openapi.yaml                   # OpenAPI specification
│       └── openapi-generator-config.yaml  # Generator configuration
└── README.md
```

## Production Considerations

Before deploying to production:

1. **Replace in-memory storage** with a proper database (PostgreSQL, MySQL, etc.)
2. **Add authentication** and authorization
3. **Configure CORS** to only allow your app's domain
4. **Add logging** and monitoring
5. **Set up SSL/TLS** for HTTPS
6. **Add rate limiting** to prevent abuse
7. **Implement proper error handling** and validation

## License

This project is part of the MahJong Scores application.
