import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class Navbar extends StatelessWidget {
  final VoidCallback onServicesTap;
  final VoidCallback onAboutTap;
  final VoidCallback onPortfolioTap;
  final VoidCallback onReviewsTap;
  final VoidCallback onContactTap;

  const Navbar({
    super.key,
    required this.onServicesTap,
    required this.onAboutTap,
    required this.onPortfolioTap,
    required this.onReviewsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 980;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF061022).withValues(alpha: 0.85),
        border: const Border(
          bottom: BorderSide(
            color: Color(0x2238BDF8),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Brand Logo & Title
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cyanAccent.withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.surfaceLight,
                          child: const Icon(
                            Icons.code_rounded,
                            color: AppColors.cyanAccent,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'NEURALIX',
                              style: GoogleFonts.orbitron(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: ' APPS',
                              style: GoogleFonts.orbitron(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: AppColors.cyanAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextSpan(
                        text: 'SOLUTIONS • IT FREELANCING',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2.2,
                          color: AppColors.textMuted,
                        ),
                      ).toWidget(),
                    ],
                  ),
                ],
              ),
            ),

            // Desktop Nav Links
            if (!isMobile)
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NavLink(title: 'Services', onTap: onServicesTap),
                      _NavLink(title: 'Founder & Team', onTap: onAboutTap),
                      _NavLink(title: 'Portfolio (20+)', onTap: onPortfolioTap),
                      _NavLink(title: 'Client Reviews', onTap: onReviewsTap),
                      const SizedBox(width: 16),
                      _QuoteButton(onTap: onContactTap),
                    ],
                  ),
                ),
              )
            else
              // Mobile Action
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.mail_outline_rounded, color: AppColors.cyanAccent),
                    onPressed: onContactTap,
                    tooltip: 'Contact Us',
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu_rounded, color: Colors.white),
                    onPressed: () {
                      _showMobileMenu(context);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF08142C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.layers_outlined, color: AppColors.cyanAccent),
                title: const Text('Services'),
                onTap: () {
                  Navigator.pop(context);
                  onServicesTap();
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline_rounded, color: AppColors.cyanAccent),
                title: const Text('Founder: Mr. Hemant Lakhara'),
                onTap: () {
                  Navigator.pop(context);
                  onAboutTap();
                },
              ),
              ListTile(
                leading: const Icon(Icons.verified_outlined, color: AppColors.cyanAccent),
                title: const Text('20+ Global Projects'),
                onTap: () {
                  Navigator.pop(context);
                  onPortfolioTap();
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_outline_rounded, color: AppColors.cyanAccent),
                title: const Text('Client Reviews'),
                onTap: () {
                  Navigator.pop(context);
                  onReviewsTap();
                },
              ),
              ListTile(
                leading: const Icon(Icons.send_rounded, color: AppColors.cyanAccent),
                title: const Text('Get Project Quote'),
                onTap: () {
                  Navigator.pop(context);
                  onContactTap();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

extension on TextSpan {
  Widget toWidget() => Text.rich(this);
}

class _NavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavLink({required this.title, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            widget.title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
              color: _isHovered ? AppColors.cyanAccent : AppColors.textWhite,
            ),
          ),
        ),
      ),
    );
  }
}

class _QuoteButton extends StatefulWidget {
  final VoidCallback onTap;
  const _QuoteButton({required this.onTap});

  @override
  State<_QuoteButton> createState() => _QuoteButtonState();
}

class _QuoteButtonState extends State<_QuoteButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: AppColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: _isHovered ? 0.6 : 0.35),
              blurRadius: _isHovered ? 16 : 10,
              spreadRadius: _isHovered ? 1 : 0,
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: widget.onTap,
          icon: const Icon(Icons.rocket_launch_rounded, size: 16),
          label: const Text('Get Free Quote'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
