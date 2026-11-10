import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactTap;
  final VoidCallback onExploreTap;

  const HeroSection({
    super.key,
    required this.onContactTap,
    required this.onExploreTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 960;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: isMobile ? 40 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _buildLogoVisual(isMobile: true),
                    const SizedBox(height: 36),
                    _buildContent(isMobile: true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 6, child: _buildContent(isMobile: false)),
                    const SizedBox(width: 48),
                    Expanded(flex: 5, child: _buildLogoVisual(isMobile: false)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildContent({required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Pill tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF0C244C),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.cyanAccent.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyanAccent.withValues(alpha: 0.2),
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF10B981), // active green dot
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Available for Global IT Projects • 20+ Completed',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cyanAccent,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Main Title
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w800,
              height: 1.15,
              color: Colors.white,
            ),
            children: const [
              TextSpan(text: 'We Engineer High-End\n'),
              TextSpan(
                text: 'Apps, Websites & Software\n',
                style: TextStyle(
                  color: AppColors.cyanAccent,
                  shadows: [
                    Shadow(
                      color: AppColors.primaryBlue,
                      blurRadius: 24,
                    ),
                  ],
                ),
              ),
              TextSpan(
                text: 'To Accelerate Your Business Growth',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle description
        Text(
          'Neuralix Apps Solutions is a dedicated IT freelancing powerhouse led by Mr. Hemant Lakhara. With an elite team of developers and specialized individual talent, we have successfully designed and delivered 20+ web and mobile apps for foreign clients worldwide.',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 14 : 16,
            height: 1.6,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 32),

        // Call to actions
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 14,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withValues(alpha: 0.4),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: widget.onContactTap,
                icon: const Icon(Icons.rocket_launch_rounded),
                label: const Text('Start Your Project'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: widget.onExploreTap,
              icon: const Icon(Icons.dashboard_customize_outlined, color: Colors.white),
              label: const Text('Explore Services', style: TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0x5538BDF8), width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color(0x220B1933),
              ),
            ),
          ],
        ),
        const SizedBox(height: 36),

        // Highlights row
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 24,
          runSpacing: 12,
          children: [
            _buildCheckBadge('20+ Foreign Client Projects'),
            _buildCheckBadge('Full-Stack Team & Individual Support'),
            _buildCheckBadge('Gurgaon Tech Hub'),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckBadge(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.verified_rounded, color: AppColors.cyanAccent, size: 18),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoVisual({required bool isMobile}) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final pulseValue = _pulseController.value;
        final double logoSize = isMobile ? 260 : 380;

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ambient glow ring
              Container(
                width: logoSize + 40 + (pulseValue * 20),
                height: logoSize + 40 + (pulseValue * 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.cyanAccent.withValues(alpha: 0.25 - (pulseValue * 0.1)),
                      AppColors.primaryBlue.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Animated cyber ring
              Container(
                width: logoSize + 16,
                height: logoSize + 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.cyanAccent.withValues(alpha: 0.4 + (pulseValue * 0.4)),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyanAccent.withValues(alpha: 0.35),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),

              // Actual Logo Container
              Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF050E1E),
                  border: Border.all(
                    color: AppColors.cyanAccent,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.6),
                      blurRadius: 35,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.code_rounded, size: 64, color: AppColors.cyanAccent),
                          const SizedBox(height: 12),
                          Text(
                            'NEURALIX',
                            style: GoogleFonts.orbitron(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Floating Tech Badge 1: App Development
              Positioned(
                top: 20,
                right: 0,
                child: _buildFloatingTag(
                  icon: Icons.phone_android_rounded,
                  label: 'App Dev',
                  color: AppColors.cyanAccent,
                ),
              ),

              // Floating Tech Badge 2: Web Solutions
              Positioned(
                bottom: 25,
                left: 0,
                child: _buildFloatingTag(
                  icon: Icons.language_rounded,
                  label: 'Web Dev',
                  color: AppColors.primaryBlue,
                ),
              ),

              // Floating Tech Badge 3: 20+ Completed
              Positioned(
                bottom: 10,
                right: 20,
                child: _buildFloatingTag(
                  icon: Icons.check_circle_rounded,
                  label: '20+ Delivered',
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingTag({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF081733).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
