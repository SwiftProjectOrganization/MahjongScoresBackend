# Setup Checklist for MahJong Scores with Vapor Backend

## ✅ Completed by Claude

- [x] Created TournamentDTO and ScoreDTO for JSON serialization
- [x] Created OpenAPI specification (openapi.yaml)
- [x] Created API client service (TournamentAPIService.swift)
- [x] Created sync UI (SyncTournamentView.swift)
- [x] Updated TournamentView with sync button
- [x] Created Vapor backend project structure
- [x] Implemented API handler with in-memory storage
- [x] Configured CORS for development
- [x] Created comprehensive documentation

## 📋 You Need to Do

### 1. Add Swift Package Dependencies to iOS Project

**IMPORTANT**: The iOS app won't build until you add these dependencies!

In Xcode:
1. Open `MahJong_Scores_4_0.xcodeproj`
2. Go to **File > Add Package Dependencies**
3. Add these three packages:

   - [ ] **swift-openapi-runtime**
     - URL: `https://github.com/apple/swift-openapi-runtime`
     - Version: 1.0.0 or later
   
   - [ ] **swift-openapi-urlsession**
     - URL: `https://github.com/apple/swift-openapi-urlsession`
     - Version: 1.0.0 or later
   
   - [ ] **swift-openapi-generator**
     - URL: `https://github.com/apple/swift-openapi-generator`
     - Version: 1.0.0 or later

### 2. Configure OpenAPI Generator Plugin

1. Select your app target
2. Go to **Build Phases** tab
3. Find or add **Run Build Tool Plug-ins** section
4. Click **+** button
5. Select **OpenAPIGenerator** from the list

   - [ ] OpenAPI Generator plugin added to build phases

### 3. Verify File Targets

Ensure these files are added to your app target (check in File Inspector):

   - [ ] `API/openapi.yaml`
   - [ ] `API/openapi-generator-config.yaml`
   - [ ] `API/TournamentAPIService.swift`
   - [ ] `Model/DTO/TournamentDTO.swift`
   - [ ] `Views/Tournament Views/SyncTournamentView.swift`

### 4. Test Backend Server

```bash
cd /Users/rob/Projects/Swift/Apps/MahJongScoresBackend
swift package resolve
swift build
swift run
```

   - [ ] Backend builds successfully
   - [ ] Backend starts on http://localhost:8081
   - [ ] Can access http://localhost:8081/tournaments (should return empty array)

### 5. Test iOS App

1. Clean build folder: Product > Clean Build Folder (⇧⌘K)
2. Build project (⌘B)
3. Run app (⌘R)

   - [ ] iOS app builds successfully
   - [ ] OpenAPI Generator creates Client types
   - [ ] App launches without errors
   - [ ] Sync button (↻) appears in toolbar

### 6. Test Sync Functionality

1. Create or select a tournament in the app
2. Tap sync button (↻)
3. Verify server URL: http://localhost:8081
4. Select a tournament
5. Tap Upload

   - [ ] Sync view opens
   - [ ] Can connect to server
   - [ ] Can upload tournament
   - [ ] Success message appears

### 7. Verify Backend Received Data

```bash
curl http://localhost:8080/tournaments
```

   - [ ] Backend returns uploaded tournament data

## 🔧 If You Encounter Issues

### Issue: "Cannot find 'Client' in scope"

This means OpenAPI Generator hasn't run yet.

**Solution**:
1. Verify OpenAPI Generator plugin is in Build Phases
2. Verify openapi.yaml and config file are in project
3. Clean build folder (⇧⌘K)
4. Build again (⌘B)

### Issue: "Connection refused" when syncing

Backend server isn't running.

**Solution**:
```bash
cd /Users/rob/Projects/Swift/Apps/MahJongScoresBackend
swift run
```

### Issue: Backend won't build

**Solution**:
```bash
cd /Users/rob/Projects/Swift/Apps/MahJongScoresBackend
swift package clean
swift package resolve
swift build
```

### Issue: Vapor/OpenAPIVapor not found

Check Package.swift URLs and versions match exactly:
- vapor: 4.99.0 or later
- swift-openapi-generator: 1.0.0 or later
- swift-openapi-runtime: 1.0.0 or later
- swift-openapi-vapor: 1.0.0 or later

## 📚 Documentation Reference

- **Quick Start**: `/Users/rob/Projects/Swift/Apps/QUICK_START_GUIDE.md`
- **Implementation Details**: `MahJong_Scores_4_0/IMPLEMENTATION_SUMMARY.md`
- **API Documentation**: `MahJong_Scores_4_0/API/README.md`
- **Backend README**: `/Users/rob/Projects/Swift/Apps/MahJongScoresBackend/README.md`

## 🎯 Success Criteria

Your setup is complete when:

- [ ] iOS app builds without errors
- [ ] Backend server starts successfully
- [ ] Can create tournaments in iOS app
- [ ] Can sync tournaments to backend
- [ ] Can verify data in backend with curl
- [ ] Connection status shows "Connected" in sync view

## 🚀 Next Steps After Setup

Once everything is working:

1. **Test thoroughly**: Upload multiple tournaments, test all operations
2. **Review code**: Understand how DTOs and API client work
3. **Customize**: Modify openapi.yaml to add features
4. **Plan production**: Consider authentication, database, HTTPS

## 📝 Notes

- The backend uses in-memory storage (data lost on restart)
- Default server URL is http://localhost:8080
- Both iOS app and backend must use same openapi.yaml
- SwiftOpenAPI Generator runs automatically during build
- Backend logs appear in Terminal where you run `swift run`

Good luck! 🎉
