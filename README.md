# KD Party — Flutter starter with cloud APK build

This project contains the initial KD Party UI prototype and a GitHub Actions workflow that can build a release APK in GitHub's cloud runner.

## Build the APK using an Android phone

1. Create or open a GitHub repository while signed in.
2. Upload the contents of this ZIP into the repository root (not the ZIP file itself). Ensure `pubspec.yaml`, `lib/main.dart`, and `.github/workflows/build-apk.yml` are at those exact paths.
3. Commit the uploaded files to the `main` or `master` branch.
4. Open the repository's **Actions** tab. Select **Build KD Party APK**.
5. Tap **Run workflow** and confirm. Wait for the workflow to finish with a green check mark.
6. Open the completed workflow run, scroll to **Artifacts**, and download **KD-Party-APK**. Extract the downloaded artifact ZIP to get `app-release.apk`.

If the Actions tab is missing, open repository Settings → Actions → General and allow actions for the repository, if you have permission.

## What this is

The included screens are a UI prototype: home, room list/detail, local demo chat, gift shop, demo coin balance, wallet, and profile.

## Important limitations

A successful APK build does NOT make this a production-ready live-party platform. Real authentication, persistent server-backed chat, multi-user live voice/video, moderation/reporting, notifications, coin purchase, VIP subscriptions, payouts, privacy policy, and secure backend rules still need implementation and testing. The current room chat and coin actions are demo/local only; no real payment or payout is implemented.
