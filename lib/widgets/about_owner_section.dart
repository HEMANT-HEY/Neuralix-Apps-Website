import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class AboutOwnerSection extends StatelessWidget {
  final VoidCallback onContactTap;

  const AboutOwnerSection({super.key, required this.onContactTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 850;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: EdgeInsets.all(isMobile ? 24 : 48),
            decoration: BoxDecoration(
              color: const Color(0xFF091733),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: const Color(0x3338BDF8), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  blurRadius: 40,
                ),
              ],
            ),
            child: isMobile
                ? Column(
                    children: [
                      _buildOwnerBadge(isMobile: true),
                      const SizedBox(height: 32),
                      _buildOwnerContent(isMobile: true),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 5, child: _buildOwnerBadge(isMobile: false)),
                      const SizedBox(width: 48),
                      Expanded(flex: 7, child: _buildOwnerContent(isMobile: false)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildOwnerBadge({required bool isMobile}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Ambient glow
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.cyanAccent.withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Profile Card / Avatar Graphic
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyanAccent.withValues(alpha: 0.5),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/hemant_lakhara.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.person_pin_rounded,
                      size: 96,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // Badge
            Positioned(
              bottom: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF061022),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.cyanAccent, width: 1.2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified, size: 14, color: AppColors.cyanAccent),
                    const SizedBox(width: 6),
                    Text(
                      'Verified Founder',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Mr. Hemant Lakhara',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Main Owner & Lead Solutions Architect',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.cyanAccent,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Neuralix Apps Solutions • Gurgaon, India',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () async {
            final uri = Uri.parse('https://www.linkedin.com/in/hemant-l-06ba8821a');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0077B5).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF0A66C2), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0A66C2).withValues(alpha: 0.25),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.link_rounded, size: 16, color: Color(0xFF38BDF8)),
                const SizedBox(width: 8),
                Text(
                  'LinkedIn Profile',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_outward_rounded, size: 13, color: Color(0xFF38BDF8)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOwnerContent({required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0x2238BDF8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x4438BDF8)),
          ),
          child: Text(
            'ABOUT LEADERSHIP & DEDICATED TEAM',
            style: GoogleFonts.orbitron(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.cyanAccent,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Trusted Engineering That Converts Ideas into Reality',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Under the leadership of Mr. Hemant Lakhara, Neuralix Apps Solutions brings together a handpicked squad of full-stack software engineers, mobile developers, UI/UX designers, and specialized individual freelancers.\n\nOur journey is backed by 20+ completed and launched web and mobile applications for foreign clients across the United States, Europe, Australia, and the Middle East. Whether you need an end-to-end dedicated team or an agile individual specialist to solve mission-critical code, we deliver with 100% precision, transparent communication, and unyielding dedication.',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            fontSize: 14,
            height: 1.65,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 24),

        // Key Value Highlights
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _buildFeaturePill('Direct Founder Access'),
            _buildFeaturePill('20+ Foreign Client Deliveries'),
            _buildFeaturePill('Dedicated & Individual Capacity'),
            _buildFeaturePill('NDA & IP Protection Guaranteed'),
          ],
        ),
        const SizedBox(height: 28),

        ElevatedButton.icon(
          onPressed: onContactTap,
          icon: const Icon(Icons.handshake_rounded),
          label: const Text('Partner With Us'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturePill(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF061022),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x3338BDF8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline_rounded,
              size: 16, color: AppColors.cyanAccent),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

