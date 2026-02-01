# 🔧 SHA-1 Fingerprint Setup - REQUIRED for Google Sign In

## ⚠️ IMPORTANT: Your SHA-1 Fingerprint

**Your SHA-1 fingerprint is:**
```
1F:E4:20:65:E9:F0:10:8F:6F:9D:62:CB:B5:33:0C:FF:DA:9D:32:C9
```

## 📋 Step-by-Step Instructions to Add SHA-1 to Firebase

### Step 1: Go to Firebase Console
1. Open your browser and go to: https://console.firebase.google.com/
2. Sign in with your Google account
3. Select your project: **ecommerce2-cffd1**

### Step 2: Open Project Settings
1. Click the **⚙️ (gear icon)** next to "Project Overview" in the left sidebar
2. Select **"Project settings"**

### Step 3: Find Your Android App
1. Scroll down to the **"Your apps"** section
2. Find your Android app: `com.example.e_commerce`
3. If you don't see it, click **"Add app"** and select Android, then add:
   - Package name: `com.example.e_commerce`
   - App nickname: NUR COLLECTION (optional)
   - Download the `google-services.json` again if needed

### Step 4: Add SHA-1 Fingerprint
1. In the Android app section, find **"SHA certificate fingerprints"**
2. Click **"Add fingerprint"** button
3. Paste your SHA-1: `1F:E4:20:65:E9:F0:10:8F:6F:9D:62:CB:B5:33:0C:FF:DA:9D:32:C9`
4. Click **"Save"**

### Step 5: Download Updated google-services.json (if needed)
1. If Firebase asked you to download `google-services.json` again, click the download button
2. Replace the file at: `android/app/google-services.json`

### Step 6: Wait 5-10 Minutes
- Firebase needs a few minutes to propagate the changes
- You may need to wait before testing

### Step 7: Rebuild and Test
```bash
flutter clean
flutter pub get
flutter run
```

## ✅ Additional Configuration (if still not working)

### 1. Enable Google Sign-In API
1. Go to: https://console.cloud.google.com/
2. Select project: **ecommerce2-cffd1**
3. Go to **APIs & Services** > **Library**
4. Search for **"Google Sign-In API"**
5. Click **"Enable"**

### 2. Configure OAuth Consent Screen
1. In Google Cloud Console, go to **APIs & Services** > **OAuth consent screen**
2. Configure:
   - User Type: **External** (for testing)
   - App name: **NUR COLLECTION**
   - User support email: Your email
   - Developer contact: Your email
3. Add scopes:
   - `.../auth/userinfo.email`
   - `.../auth/userinfo.profile`
4. Add test users (if using External type):
   - Add your Google account email
5. Click **"Save and Continue"** through all steps

### 3. Check Firestore Security Rules
Make sure your Firestore rules allow authenticated users:

1. Go to Firebase Console > Firestore Database > Rules
2. Use these rules:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /products/{productId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    match /orders/{orderId} {
      allow read, write: if request.auth != null && request.auth.uid == resource.data.userId;
    }
  }
}
```

## 🧪 Testing

After completing all steps:
1. **Clean and rebuild:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

2. **Check console logs** - You should see:
   - "Google Sign In: Starting authentication flow"
   - "Google Sign In: User selected - [email]"
   - "Google Sign In: ID Token received successfully"
   - "Google Sign In: Successfully signed in - [email]"

3. **If you see errors:**
   - Check the console output for specific error codes
   - Common errors:
     - `DEVELOPER_ERROR`: SHA-1 not added correctly
     - `12500`: OAuth consent screen not configured
     - `10`: Package name mismatch

## 📱 For Release Build (Later)

When you're ready to build for release, you'll need to:
1. Get the release SHA-1 (from your release keystore)
2. Add it to Firebase Console as well
3. The debug and release SHA-1 are different

---

## 🆘 Troubleshooting

**If sign-in still fails after adding SHA-1:**
1. Wait 10-15 minutes for Firebase to propagate changes
2. Make sure you added the SHA-1 to the correct project
3. Verify the package name matches: `com.example.e_commerce`
4. Check if OAuth consent screen is configured
5. Verify Google Sign-In API is enabled
6. Check console logs for specific error messages
