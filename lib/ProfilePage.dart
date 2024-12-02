import 'package:flutter/material.dart';
import 'package:sih_shetkari/LoginPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  final Color greenColor = const Color(0xFF4CAF50);

  const ProfilePage({super.key}); // Green color for the background and buttons

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            localizations.profile,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Info Section
            Container(
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: Colors.black, width: 3), // Outline for the container
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "[Username]",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "[email-id]",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "[location]",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "[Phone No.]",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Circular Avatar with Shadow and Outline
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black, // Outline color
                        width: 3, // Outline thickness
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5), // Shadow color
                          blurRadius: 10, // Soft edges
                          spreadRadius: 2, // Spread distance
                          offset: const Offset(2, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Menu Options
            ListTile(
              title: Text(localizations.edit_pfp),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Edit Profile Page
              },
            ),
            const Divider(),
            ListTile(
              title: Text(localizations.history),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to History Page
              },
            ),
            const Divider(),
            ListTile(
              title: Text(localizations.saved),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Saved Page
              },
            ),
            const Divider(),
            const Spacer(),
            // Sign Out Button
            ElevatedButton(
              onPressed: () {
                // Redirect to Sign In Page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) =>
                      false, // Removes all previous routes
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(localizations.signout),
            ),
          ],
        ),
      ),
    );
  }
}
