# Fix Firestore Permission Error

## Problem
Error: `[cloud_firestore/permission-denied]` - The app cannot read/write to Firestore.

## Solution
Update Firestore Security Rules in Firebase Console:

### Steps:
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click on **Firestore Database** in the left sidebar
4. Click on the **Rules** tab
5. Replace the existing rules with the following:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read all products
    match /products/{product} {
      allow read: if true;  // Anyone can read products
      allow write: if request.auth != null;  // Only authenticated users can write
    }
    
    // Allow authenticated users to read/write their own user data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow authenticated users to read/write their own orders
    match /orders/{order} {
      allow read: if request.auth != null && request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && request.auth.uid == request.resource.data.userId;
    }
  }
}
```

6. Click **Publish** button

## What These Rules Do:
- **Products**: Anyone can read products (even without login). Only authenticated users can add products.
- **Users**: Users can only read/write their own user document.
- **Orders**: Users can only read their own orders and create orders for themselves.

## After Updating Rules:
1. Restart your Flutter app
2. The products should load without errors
3. Use the "Add Dummy Data" button in Profile to add sample products
