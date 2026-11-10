import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onServicesTap;
  final VoidCallback onAboutTap;
  final VoidCallback onPortfolioTap;
  final VoidCallback onContactTap;

  const FooterSection({
    super.key,
    required this.onServicesTap,
    required this.onAboutTap,
    required this.onPortfolioTap,
    required this.onContactTap,
  });

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
      decoration: const BoxDecoration(
        color: Color(0xFF040A17),
        border: Border(
          top: BorderSide(
            color: Color(0x2238BDF8),
            width: 1.5,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Top Footer Grid
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBrandInfo(),
                        const SizedBox(height: 32),
                        _buildContactDetails(),
                        const SizedBox(height: 32),
                        _buildQuickLinks(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: _buildBrandInfo()),
                        const SizedBox(width: 48),
                        Expanded(flex: 4, child: _buildContactDetails()),
                        const SizedBox(width: 36),
                        Expanded(flex: 3, child: _buildQuickLinks()),
                      ],
                    ),

              const SizedBox(height: 40),
              const Divider(color: Color(0x1A38BDF8)),
              const SizedBox(height: 24),

              // Bottom Copyright strip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Text(
                          '© 2026 Neuralix Apps Solutions. All Rights Reserved. Founded by Mr. Hemant Lakhara.',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textDark,
                          ),
                        ),
                        InkWell(
                          onTap: _openPrivacyPolicy,
                          child: Text(
                            'Privacy Policy',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.cyanAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera_alt_outlined, color: AppColors.cyanAccent, size: 20),
                        tooltip: 'Instagram @neuralix_apps_solutions',
                        onPressed: () => _launch('https://www.instagram.com/neuralix_apps_solutions'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mail_outline_rounded, color: AppColors.cyanAccent, size: 20),
                        tooltip: 'Email Us',
                        onPressed: () => _launch('mailto:neuralixapps.official@gmail.com'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.cyanAccent, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyanAccent.withValues(alpha: 0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.code_rounded,
                    color: AppColors.cyanAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEURALIX APPS SOLUTIONS',
                    style: GoogleFonts.orbitron(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Build • Innovate • Grow',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.cyanAccent,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Premier IT freelancing & engineering agency. Specializing in App Development, Website Development, Custom Software, UI/UX Design, and digital transformation. 20+ completed solutions for global clientele.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textMuted,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Main Owner & Lead: Mr. Hemant Lakhara',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildContactDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONTACT & LOCATION',
          style: GoogleFonts.orbitron(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.cyanAccent,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),

        // Instagram
        InkWell(
          onTap: () => _launch('https://www.instagram.com/neuralix_apps_solutions'),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.camera_alt_outlined, color: AppColors.cyanAccent, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'neuralix_apps_solutions',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Email
        InkWell(
          onTap: () => _launch('mailto:neuralixapps.official@gmail.com'),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.mail_outline_rounded, color: AppColors.cyanAccent, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'neuralixapps.official@gmail.com',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Address (Only Gurgaon as requested)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_outlined, color: AppColors.cyanAccent, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Gurgaon, India',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXPLORE',
          style: GoogleFonts.orbitron(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.cyanAccent,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink('Our Services', onServicesTap),
        _buildFooterLink('Leadership & Team', onAboutTap),
        _buildFooterLink('20+ Delivered Projects', onPortfolioTap),
        _buildFooterLink('Request a Quote', onContactTap),
        _buildFooterLink('Privacy Policy', _openPrivacyPolicy),
      ],
    );
  }

  Widget _buildFooterLink(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
