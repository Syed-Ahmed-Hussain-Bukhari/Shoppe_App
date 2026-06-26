# Firebase Testing Instructions — Shoppe App

## 1. Get Your FCM Token
Open the app → Settings → copy the FCM Device Token shown on screen.

## 2. Send a Push Notification
Go to Firebase Console → Messaging → New Campaign → Notification.
Add any title & body, then under Additional Options → Custom Data add:
- product_id → 5
- type → product

Set target to "Single device" and paste your copied token → Send.

## 3. Test These Scenarios

**Foreground** — Keep the app open and send the push.
Notification banner should appear on screen.

**Background** — Minimise the app and send the push.
Tap the notification → should open Product #5 detail screen.

**Terminated** — Force close the app and send the push.
Reopen the app → should navigate directly to Product #5 detail screen.

## 4. Quick Local Test
Settings → tap "Send Test Notification" → check notification panel → tap it → should open Product #5.
