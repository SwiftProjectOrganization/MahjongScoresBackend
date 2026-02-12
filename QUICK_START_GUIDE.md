# MahJong Scores Backend - Quick Start Guide

## Prerequisites

- Xcode 15.0 or later
- Swift 6.2 or later
- macOS 14.0 or later

## Important: Add Required Dependencies to iOS Project

Before building, you need to add SwiftOpenAPI dependencies to your Xcode project:

### Step 1: Add Package Dependencies

1. Open `MahJong_Scores_4_0.xcodeproj` in Xcode
2. Go to **File > Add Package Dependencies**
3. Add these packages:

   **Swift OpenAPI Runtime**
   - URL: `https://github.com/apple/swift-openapi-runtime`
   - Version: 1.0.0 or later
   
   **Swift OpenAPI URLSession**
   - URL: `https://github.com/apple/swift-openapi-urlsession`
   - Version: 1.0.0 or later
   
   **Swift OpenAPI Generator**
   - URL: `https://github.com/apple/swift-openapi-generator`
   - Version: 1.0.0 or later

### Step 2: Configure Build Plugin

1. Select your app target in Xcode
2. Go to **Build Phases**
3. Expand **Run Build Tool Plug-ins**
4. Click **+** and add **OpenAPIGenerator**

### Step 3: Add Files to Target

Make sure these files are included in your app target:
- `API/openapi.yaml`
- `API/openapi-generator-config.yaml`
- `API/TournamentAPIService.swift`
- `Model/DTO/TournamentDTO.swift`
- `Views/Tournament Views/SyncTournamentView.swift`

## Starting the Backend Server

### Terminal 1: Start Backend

```bash
cd /Users/rob/Projects/Swift/Apps/MahJongScoresBackend
swift run
```

Expected output:
```
[ NOTICE ] Server starting on http://127.0.0.1:8080
[ INFO ] Server configured and ready to accept connections on port 8080
```

### Terminal 2 (Optional): Test the API

```bash
# List tournaments (should be empty)
curl http://localhost:8080/tournaments

# Create a test tournament
curl -X POST http://localhost:8080/tournaments \
  -H "Content-Type: application/json" \
  -d '{"id":"550e8400-e29b-41d4-a716-446655440000","scheduleItem":0}'
```

## Running the iOS App

1. Open `MahJong_Scores_4_0.xcodeproj` in Xcode
2. Select your target device/simulator
3. Build and Run (⌘R)

## Syncing Tournaments

1. In the iOS app, tap the **sync button (↻)** in the toolbar
2. Verify server URL: `http://localhost:8080`
3. Select tournaments to upload
4. Tap **Upload**
5. Check sync status

## Troubleshooting

### Build Error: "Cannot find 'Client' in scope"

**Solution**: The OpenAPI Generator hasn't run yet.
- Clean build folder: Product > Clean Build Folder (⇧⌘K)
- Build again (⌘B)
- The plugin will generate the required code

### Runtime Error: "Connection refused"

**Solution**: Backend server not running.
- Start the backend server in Terminal (see above)
- Verify it's running on port 8080

### Sync Error: "Bad request"

**Solution**: Data format mismatch.
- Ensure both iOS app and backend use the same `openapi.yaml`
- Rebuild both projects after any changes to the spec

### iOS App Doesn't Show Sync Button

**Solution**: Build issue with updated TournamentView.
- Clean build folder
- Rebuild the project

## File Locations Reference

```
iOS App:
  MahJong_Scores_4_0/
  ├── API/
  │   ├── openapi.yaml                      # API specification
  │   ├── openapi-generator-config.yaml     # Generator config
  │   ├── TournamentAPIService.swift        # API client
  │   └── README.md                         # Detailed docs
  ├── Model/
  │   └── DTO/
  │       └── TournamentDTO.swift           # Transfer objects
  └── Views/
      └── Tournament Views/
          ├── TournamentView.swift          # Main list (updated)
          └── SyncTournamentView.swift      # Sync UI

Backend:
  MahJongScoresBackend/
  ├── Package.swift                         # Dependencies
  ├── Sources/
  │   └── MahJongScoresBackend/
  │       ├── MahJongScoresBackend.swift    # Main app
  │       ├── TournamentAPIHandler.swift    # API implementation
  │       ├── openapi.yaml                  # API spec (copy)
  │       └── openapi-generator-config.yaml # Generator config
  └── README.md                             # Backend docs
```

## Next Steps

1. **Test the sync**: Create a tournament and upload it
2. **Review the code**: Check out the implementation files
3. **Read the docs**: See `API/README.md` for details
4. **Customize**: Modify `openapi.yaml` to add features

## Common Commands

```bash
# Backend: Resolve dependencies
cd /Users/rob/Projects/Swift/Apps/MahJongScoresBackend
swift package resolve

# Backend: Clean build
swift package clean

# Backend: Run server
swift run

# Backend: Build only (no run)
swift build

# iOS: Clean build (in Xcode)
# Product > Clean Build Folder (⇧⌘K)
```

## Support

For detailed documentation:
- Backend: `/Users/rob/Projects/Swift/Apps/MahJongScoresBackend/README.md`
- API Integration: `MahJong_Scores_4_0/API/README.md`
- Implementation Details: `MahJong_Scores_4_0/IMPLEMENTATION_SUMMARY.md`
