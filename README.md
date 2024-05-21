# login_localmarket

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

project setting

  1. yaml dependency 추가
    supabase_flutter: ^2.5.3
    image_picker: ^1.1.1

  2. ios - info.plist 수정
    // login setting 
    <key>CFBundleURLTypes</key>
        <array>
            <dict>
              <key>CFBundleTypeRole</key>
              <string>Editor</string>
              <key>CFBundleURLSchemes</key>
              <array>
                <string>io.supabase.flutterquickstart</string>
              </array>
            </dict>
        </array>
    // imagepicker setting
    <key>NSPhotoLibraryUsageDescription</key>
    <string>need to access the photo library</string>
    <key>NSCameraUsageDescription</key>
    <string>need to access the camera</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>need to access the mic</string>
    
  3. andriod - androidmanifest.xml 수정
    <!-- login settings -->
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <!-- Accepts URIs that begin with YOUR_SCHEME://YOUR_HOST -->
        <data
            android:scheme="io.supabase.flutterquickstart"
            android:host="login-callback" />
    </intent-filter>

  4. main.dart 내 supabase initialize setting
    url: 'SUPABASE_URL',
    anonKey:'SUPABASE_ANON_KEY'
