# Fix "Access is denied" and "Unable to determine engine version" Error

## Problem
You're getting:
- `Access is denied`
- `Error: Unable to determine engine version...`
- `FAILURE: Build failed with an exception`

## Solution 1: Run PowerShell as Administrator (RECOMMENDED)

1. **Close VS Code/PowerShell completely**
2. **Right-click on PowerShell** → **Run as Administrator**
3. Navigate to your project:
   ```powershell
   cd D:\E_commerse\e_commerce
   ```
4. Run the app:
   ```powershell
   flutter clean
   flutter pub get
   flutter run
   ```

## Solution 2: Enable Developer Mode (Alternative)

1. Press `Windows Key + I` to open Settings
2. Go to **Update & Security** → **For developers**
3. Enable **Developer Mode**
4. Restart your computer
5. Try running again

## Solution 3: Check Antivirus/Security Software

Your antivirus might be blocking Flutter:
1. Temporarily disable antivirus
2. Add Flutter folder to exclusions:
   - Add `C:\flutter` to antivirus exclusions
   - Add project folder `D:\E_commerse\e_commerce` to exclusions
3. Try building again

## Solution 4: Fix Flutter Permissions

Run these commands in **Administrator PowerShell**:

```powershell
# Take ownership of Flutter directory
takeown /F C:\flutter /R /D Y
icacls C:\flutter /grant %USERNAME%:F /T

# Then try again
cd D:\E_commerse\e_commerce
flutter clean
flutter pub get
flutter run
```

## Solution 5: Use Android Studio to Run

1. Open **Android Studio**
2. Open your project: `D:\E_commerse\e_commerce`
3. Click the **Run** button (green play icon)
4. Select your device: **TECNO KI7**
5. Android Studio will handle the build with proper permissions

## Solution 6: Build APK and Install Manually

If all else fails:

```powershell
flutter build apk --debug
```

Then manually install the APK:
- Location: `build\app\outputs\flutter-apk\app-debug.apk`
- Copy to your phone and install

## Quick Fix (Try This First!)

**Run PowerShell as Administrator and execute:**

```powershell
cd D:\E_commerse\e_commerce
flutter clean
Remove-Item -Path ".dart_tool" -Recurse -Force -ErrorAction SilentlyContinue
flutter pub get
flutter run -d "TECNO KI7"
```

---

**Most likely solution**: Run PowerShell/VS Code as Administrator. Windows requires administrator privileges for symlink creation, which Flutter needs during build.
