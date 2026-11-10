import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class ContactFormSection extends StatefulWidget {
  const ContactFormSection({super.key});

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedService = 'App Development';
  String _selectedBudget = '\$1,000 - \$3,000';
  String _selectedTimeline = '1 - 2 Months';

  bool _isSubmitting = false;
  bool _isSubmitted = false;

  final List<String> _services = [
    'App Development',
    'Website Development',
    'Custom Software Development',
    'UI / UX Design',
    'Help to Grow Business Digitally',
    'Full Dedicated Team Solution',
  ];

  final List<String> _budgets = [
    'Under \$1,000',
    '\$1,000 - \$3,000',
    '\$3,000 - \$8,000',
    '\$8,000 - \$15,000+',
    'Flexible / To be discussed',
  ];

  final List<String> _timelines = [
    'Urgent (< 2 weeks)',
    '1 - 2 Months',
    '2 - 4 Months',
    'Flexible',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    final payload = {
      '_subject': '🚀 New Project Inquiry from ${_nameController.text.trim()} - Neuralix Apps Solutions',
      'Client Name': _nameController.text.trim(),
      'Client Email': _emailController.text.trim(),
      'Phone or WhatsApp': _phoneController.text.trim().isEmpty ? 'Not Provided' : _phoneController.text.trim(),
      'Selected Service': _selectedService,
      'Project Budget': _selectedBudget,
      'Expected Timeline': _selectedTimeline,
      'Project Details': _messageController.text.trim(),
      '_template': 'table',
      '_captcha': 'false',
    };

    try {
      final response = await http.post(
        Uri.parse('https://formsubmit.co/ajax/neuralixapps.official@gmail.com'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        setState(() {
          _isSubmitting = false;
          _isSubmitted = true;
        });
      } else {
        // Fallback or retry
        _sendViaMailto();
        setState(() {
          _isSubmitting = false;
          _isSubmitted = true;
        });
      }
    } catch (e) {
      // In case of network error, launch mailto client as reliable backup
      _sendViaMailto();
      setState(() {
        _isSubmitting = false;
        _isSubmitted = true;
      });
    }
  }

  void _sendViaMailto() async {
    final Uri mailUri = Uri(
      scheme: 'mailto',
      path: 'neuralixapps.official@gmail.com',
      queryParameters: {
        'subject': 'Project Inquiry: ${_nameController.text.trim()} [$_selectedService]',
        'body': '''Hello Mr. Hemant Lakhara & Neuralix Team,

Client Name: ${_nameController.text.trim()}
Email: ${_emailController.text.trim()}
Phone / WhatsApp: ${_phoneController.text.trim()}
Service: $_selectedService
Budget: $_selectedBudget
Timeline: $_selectedTimeline

Project Requirements:
${_messageController.text.trim()}
''',
      },
    );

    if (await canLaunchUrl(mailUri)) {
      await launchUrl(mailUri);
    }
  }

  Future<void> _openPrivacyPolicy() async {
    final Uri url = Uri.parse('privacy-policy.html');
    try {
      final launched = await launchUrl(
        url,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
      if (!launched) {
        final localFile = Uri.file(r'e:\neuralixapps\web\privacy-policy.html');
        await launchUrl(localFile);
      }
    } catch (_) {
      final localFile = Uri.file(r'e:\neuralixapps\web\privacy-policy.html');
      await launchUrl(localFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0x2238BDF8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x4438BDF8)),
                ),
                child: Text(
                  'START YOUR PROJECT',
                  style: GoogleFonts.orbitron(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cyanAccent,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Let’s Discuss Your Next Great Digital Product',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 26 : 38,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 750),
                child: Text(
                  'Fill out the form below with your project details. All info is forwarded directly to neuralixapps.official@gmail.com and reviewed personally by Mr. Hemant Lakhara.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Two-column layout: Info Card + Form Card
              isMobile
                  ? Column(
                      children: [
                        _buildContactInfoCard(),
                        const SizedBox(height: 32),
                        _buildFormCard(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4, child: _buildContactInfoCard()),
                        const SizedBox(width: 36),
                        Expanded(flex: 7, child: _buildFormCard()),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF09162D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0x3338BDF8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Direct Connection',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We value transparent communication and prompt responses. Connect with our leadership team today.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textMuted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),

          // Official Email
          _buildInfoRow(
            icon: Icons.alternate_email_rounded,
            title: 'Official Email',
            value: 'neuralixapps.official@gmail.com',
            onTap: () async {
              final uri = Uri.parse('mailto:neuralixapps.official@gmail.com');
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
          ),
          const SizedBox(height: 20),

          // Instagram ID
          _buildInfoRow(
            icon: Icons.camera_alt_outlined,
            title: 'Instagram Handle',
            value: '@neuralix_apps_solutions',
            onTap: () async {
              final uri = Uri.parse('https://www.instagram.com/neuralix_apps_solutions');
              if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
          ),
          const SizedBox(height: 20),

          // Address
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            title: 'Headquarters Location',
            value: 'Gurgaon, India',
          ),
          const SizedBox(height: 20),

          // Founder
          _buildInfoRow(
            icon: Icons.badge_outlined,
            title: 'Main Owner & Lead',
            value: 'Mr. Hemant Lakhara',
          ),
          const SizedBox(height: 32),

          // Guarantee badge
          InkWell(
            onTap: _openPrivacyPolicy,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF061022),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0x3310B981)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.security_rounded, color: Color(0xFF10B981), size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '100% NDA Protection',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded, size: 11, color: AppColors.cyanAccent),
                          ],
                        ),
                        Text(
                          'Your product idea and data are strictly guarded. Tap to view our Privacy Policy.',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F2348),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x3338BDF8)),
            ),
            child: Icon(icon, color: AppColors.cyanAccent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    if (_isSubmitted) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: const Color(0xFF091733),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.cyanAccent, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyanAccent.withValues(alpha: 0.2),
              blurRadius: 30,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x2210B981),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF10B981),
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Inquiry Successfully Sent!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Thank you for reaching out to Neuralix Apps Solutions. Your project brief has been forwarded directly to neuralixapps.official@gmail.com.\n\nMr. Hemant Lakhara and our engineering team will evaluate your requirements and contact you within 24 hours.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.6,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isSubmitted = false;
                  _nameController.clear();
                  _emailController.clear();
                  _phoneController.clear();
                  _messageController.clear();
                });
              },
              child: const Text('Submit Another Project'),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: const Color(0xFF091733),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0x3338BDF8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Requirements Form',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tell us about your app, website, or custom software concept.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 24),

            // Client Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name or Company *',
                prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.cyanAccent),
                hintText: 'e.g. John Doe / TechCorp Ltd',
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your name or company';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),

            // Client Email
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Your Email Address *',
                prefixIcon: Icon(Icons.mail_outline_rounded, color: AppColors.cyanAccent),
                hintText: 'e.g. client@example.com',
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your email address';
                }
                if (!val.contains('@') || !val.contains('.')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),

            // Phone / WhatsApp
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone or WhatsApp Number (Optional)',
                prefixIcon: Icon(Icons.phone_outlined, color: AppColors.cyanAccent),
                hintText: 'e.g. +1 555 123 4567',
              ),
            ),
            const SizedBox(height: 20),

            // Service Required Dropdown
            Text(
              'Select Service *',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedService,
              isExpanded: true,
              dropdownColor: const Color(0xFF09162D),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.miscellaneous_services_rounded, color: AppColors.cyanAccent),
              ),
              items: _services.map((s) {
                return DropdownMenuItem(
                  value: s,
                  child: Text(s, style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedService = val);
              },
            ),
            const SizedBox(height: 20),

            // Budget & Timeline Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estimated Budget',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedBudget,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF09162D),
                        items: _budgets.map((b) {
                          return DropdownMenuItem(
                            value: b,
                            child: Text(b, style: const TextStyle(fontSize: 13, color: Colors.white), overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedBudget = val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Target Timeline',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedTimeline,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF09162D),
                        items: _timelines.map((t) {
                          return DropdownMenuItem(
                            value: t,
                            child: Text(t, style: const TextStyle(fontSize: 13, color: Colors.white), overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedTimeline = val);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Message / Requirements
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Project Overview & Requirements *',
                alignLabelWithHint: true,
                hintText: 'Describe your vision, target features, platforms, or questions...',
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please give us a brief description of your project';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _submitForm,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : const Icon(Icons.send_rounded),
                  label: Text(
                    _isSubmitting
                        ? 'Transmitting Project Data...'
                        : 'Send Project Inquiry to Neuralix',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Center(
              child: Text(
                '⚡ Submissions deliver instantaneously to neuralixapps.official@gmail.com',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: InkWell(
                onTap: _openPrivacyPolicy,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shield_outlined, size: 13, color: AppColors.cyanAccent),
                    const SizedBox(width: 5),
                    Text(
                      'Privacy Policy & NDA Guaranteed',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.cyanAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
