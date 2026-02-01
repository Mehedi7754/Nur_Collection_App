import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import 'auth_screen.dart';
import 'order_history.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    authProvider.userModel?.name ?? 'User',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    authProvider.userModel?.email ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _ProfileSection(
                    title: 'Account Information',
                    children: [
                      _ProfileTile(
                        icon: Icons.email,
                        title: 'Email',
                        subtitle: authProvider.userModel?.email ?? '',
                      ),
                      _ProfileTile(
                        icon: Icons.location_on,
                        title: 'Address',
                        subtitle: authProvider.userModel?.address ?? 'Not set',
                        onTap: () => _showAddressDialog(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _ProfileSection(
                    title: 'More',
                    children: [
                      _ProfileTile(
                        icon: Icons.history,
                        title: 'Order History',
                        subtitle: 'View your past orders',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderHistoryScreen(),
                            ),
                          );
                        },
                      ),
                      _ProfileTile(
                        icon: Icons.privacy_tip,
                        title: 'Privacy Policy',
                        subtitle: 'View our privacy policy',
                        onTap: () => _showPrivacyPolicy(context),
                      ),
                      _ProfileTile(
                        icon: Icons.help_center,
                        title: 'Help Center',
                        subtitle: 'Get help and support',
                        onTap: () => _showHelpCenter(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await authProvider.signOut();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const AuthScreen()),
                            (route) => false,
                          );
                        }
                      },
                      icon: const Icon(Icons.logout, color: AppColors.white),
                      label: const Text(
                        'Sign Out',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressDialog(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final addressController = TextEditingController(
      text: authProvider.userModel?.address ?? '',
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Address'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: addressController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Address',
              hintText: 'Enter your address',
              filled: true,
              fillColor: AppColors.fieldBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await authProvider.updateAddress(addressController.text.trim());
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Address updated successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            '''NUR COLLECTION Privacy Policy

Last Updated: 2024

1. Information We Collect
We collect information you provide directly to us, including:
- Name and contact information
- Email address
- Delivery address
- Order history

2. How We Use Your Information
We use the information we collect to:
- Process and fulfill your orders
- Communicate with you about your orders
- Improve our services
- Send you promotional materials (with your consent)

3. Data Security
We implement appropriate security measures to protect your personal information.

4. Third-Party Services
We may share your information with third-party service providers to help us operate our business and serve you.

5. Your Rights
You have the right to:
- Access your personal information
- Request correction of your information
- Request deletion of your information

6. Contact Us
If you have questions about this privacy policy, please contact us.

By using our app, you agree to this privacy policy.''',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showHelpCenter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help Center'),
        content: const SingleChildScrollView(
          child: Text(
            '''NUR COLLECTION Help Center

Frequently Asked Questions:

1. How do I place an order?
- Browse our products, add items to cart, and proceed to checkout.

2. What payment methods do you accept?
- We accept various payment methods. Contact us for details.

3. How long does delivery take?
- Standard delivery takes 5-7 business days.

4. Can I cancel my order?
- You can cancel your order within 24 hours of placing it.

5. How do I track my order?
- You will receive order updates via email.

6. What is your return policy?
- Items can be returned within 14 days of delivery.

7. How do I contact customer support?
- Email: support@nurcollection.com
- Phone: +1 (555) 123-4567

8. Do you ship internationally?
- Currently, we ship within the country only.

Need more help? Contact our support team!''',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ProfileSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right, color: AppColors.grey)
          : null,
      onTap: onTap,
    );
  }
}
