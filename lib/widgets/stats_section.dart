import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF0B1938), Color(0xFF061026)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: const Color(0x3338BDF8),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: AppColors.cyanAccent.withValues(alpha: 0.08),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: isMobile
                ? Column(
                    children: [
                      _buildStatItem('20+', 'Foreign Client Projects', 'USA, UK, Europe, Australia'),
                      const Divider(color: Color(0x2238BDF8), height: 32),
                      _buildStatItem('100%', 'Project Delivery Rate', 'Strict on-time execution'),
                      const Divider(color: Color(0x2238BDF8), height: 32),
                      _buildStatItem('1 Team', 'Dedicated & Individual', 'Engineered by Hemant Lakhara'),
                      const Divider(color: Color(0x2238BDF8), height: 32),
                      _buildStatItem('24/7', 'Client Communication', 'Transparent agile workflow'),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _buildStatItem('20+', 'Foreign Client Projects', 'USA, UK, Europe, Australia')),
                      _buildVerticalDivider(),
                      Expanded(child: _buildStatItem('100%', 'Project Delivery Rate', 'Strict on-time execution')),
                      _buildVerticalDivider(),
                      Expanded(child: _buildStatItem('Dedicated', 'Engineers & Freelancers', 'Led by Hemant Lakhara')),
                      _buildVerticalDivider(),
                      Expanded(child: _buildStatItem('24/7', 'Client Communication', 'Direct agile updates')),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 60,
      width: 1,
      color: const Color(0x2238BDF8),
    );
  }

  Widget _buildStatItem(String number, String label, String sublabel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
          child: Text(
            number,
            style: GoogleFonts.orbitron(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          sublabel,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
