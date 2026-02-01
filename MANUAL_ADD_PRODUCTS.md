# 🔥 Manual Guide: Add Products to Firebase

Since the automated tools aren't working, please follow these steps to **manually add products** to your Firebase Firestore:

## Step 1: Open Firebase Console
1. Go to: https://console.firebase.google.com/
2. Sign in with your Google account
3. Click on your project: **ecommerce2-cffd1**

## Step 2: Navigate to Firestore
1. In the left sidebar, click **"Firestore Database"**
2. If you see "Create database" button, click it and choose:
   - Location: Choose closest region
   - Start in **test mode** (we already updated rules)

## Step 3: Add Products Collection
1. Click **"+ Start collection"**
2. Collection ID: Type `products`
3. Click **Next**

## Step 4: Add First Product
Add these fields for the first document (Document ID: leave as Auto-ID):

| Field Name | Type | Value |
|------------|------|-------|
| name | string | Classic White T-Shirt |
| imageUrl | string | https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400 |
| price | number | 29.99 |
| rating | number | 4.5 |
| category | string | T-shirt |
| description | string | Comfortable cotton white t-shirt |

Click **Save**

## Step 5: Add More Products
Click **"+ Add document"** and repeat with these:

### Product 2:
- name: `Black Cotton T-Shirt`
- imageUrl: `https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=400`
- price: `25.99`
- rating: `4.6`
- category: `T-shirt`
- description: `Premium black t-shirt`

### Product 3:
- name: `Blue Denim Shirt`
- imageUrl: `https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=400`
- price: `49.99`
- rating: `4.7`
- category: `Shirt`
- description: `Classic denim shirt`

### Product 4:
- name: `Formal White Shirt`
- imageUrl: `https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=400`
- price: `59.99`
- rating: `4.8`
- category: `Shirt`
- description: `Elegant formal shirt`

### Product 5:
- name: `Baby Blue Romper`
- imageUrl: `https://images.unsplash.com/photo-1522771930-78848d9293e8?w=400`
- price: `24.99`
- rating: `4.9`
- category: `Baby dress`
- description: `Adorable baby romper`

## Step 6: Verify in App
1. Open your app
2. Go to Home screen
3. Products should now appear!

## Quick Tips:
- ⚠️ **Important**: Make sure `category` field exactly matches: `T-shirt`, `Shirt`, or `Baby dress`
- Use **number** type for `price` and `rating`, not string
- Copy-paste image URLs exactly as shown

---

After adding even just 2-3 products, your app will start showing them!
