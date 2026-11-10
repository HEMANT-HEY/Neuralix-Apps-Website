import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ServicesSection extends StatelessWidget {
  final VoidCallback onSelectService;

  const ServicesSection({super.key, required this.onSelectService});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;

    final services = [
      _ServiceItem(
        title: 'App Development',
        icon: Icons.phone_android_rounded,
        tagline: 'iOS & Android Mobile Applications',
        description:
            'From initial concept to App Store & Google Play launch. We engineer high-performance cross-platform (Flutter, React Native) and native apps with smooth animations, rock-solid security, and offline support.',
        tags: ['Flutter', 'Android', 'iOS', 'Firebase', 'APIs'],
      ),
      _ServiceItem(
        title: 'Website Development',
        icon: Icons.language_rounded,
        tagline: 'Modern, Fast & Scalable Web Apps',
        description:
            'Custom web applications, client portals, SaaS platforms, and responsive portfolio sites. Built using cutting-edge frameworks with SEO optimization, interactive UI, and rapid load speeds.',
        tags: ['React', 'Next.js', 'Flutter Web', 'Node.js', 'Cloud'],
      ),
      _ServiceItem(
        title: 'Custom Software Development',
        icon: Icons.terminal_rounded,
        tagline: 'Tailored Solutions for Your Operations',
        description:
            'Bespoke software systems designed precisely around your business workflows. We develop scalable backends, database architectures, microservices, internal automation tools, and API integrations.',
        tags: ['Custom APIs', 'Databases', 'Python', 'Node.js', 'Automation'],
      ),
      _ServiceItem(
        title: 'UI / UX Design',
        icon: Icons.palette_outlined,
        tagline: 'User-Centric Visual Experiences',
        description:
            'Transforming complex ideas into clean, intuitive, and visually stunning digital products. We craft interactive Figma prototypes, design systems, design tokens, and user journeys that drive engagement.',
        tags: ['Figma', 'Prototyping', 'User Research', 'Design Systems'],
      ),
      _ServiceItem(
        title: 'Digital Business Growth',
        icon: Icons.trending_up_rounded,
        tagline: 'Scale Your Brand Online & Digitally',
        description:
            'We don’t just write code; we help businesses grow digitally. Technical SEO, cloud deployment, analytics integration, performance optimization, and strategic tech consulting to expand your international reach.',
        tags: ['Digital Strategy', 'SEO', 'Cloud Scale', 'Analytics', 'Conversion'],
      ),
    ];

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
              // Section Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0x2238BDF8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x4438BDF8)),
                ),
                child: Text(
                  'OUR CORE EXPERTISE',
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
                'Comprehensive IT & Development Services',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 26 : 38,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  'Tailored technology solutions designed and developed by our specialized team and individual talent to power your business growth.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.textMuted,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Services Grid / Wrap
              LayoutBuilder(
                builder: (context, constraints) {
                  final double cardWidth = constraints.maxWidth > 950
                      ? (constraints.maxWidth - 48) / 3
                      : constraints.maxWidth > 650
                          ? (constraints.maxWidth - 24) / 2
                          : constraints.maxWidth;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: services.map((service) {
                      return SizedBox(
                        width: cardWidth,
                        child: _ServiceCard(
                          item: service,
                          onTap: onSelectService,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceItem {
  final String title;
  final IconData icon;
  final String tagline;
  final String description;
  final List<String> tags;

  _ServiceItem({
    required this.title,
    required this.icon,
    required this.tagline,
    required this.description,
    required this.tags,
  });
}

class _ServiceCard extends StatefulWidget {
  final _ServiceItem item;
  final VoidCallback onTap;

  const _ServiceCard({required this.item, required this.onTap});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFF0F2245) : const Color(0xFF09162E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered ? AppColors.cyanAccent : const Color(0x2238BDF8),
              width: _isHovered ? 1.6 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.primaryBlue.withValues(alpha: 0.35)
                    : Colors.black.withValues(alpha: 0.3),
                blurRadius: _isHovered ? 24 : 12,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon with glowing rounded container
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: _isHovered
                      ? AppColors.primaryGradient
                      : const LinearGradient(
                          colors: [Color(0xFF132A55), Color(0xFF0B1935)],
                        ),
                  border: Border.all(
                    color: _isHovered ? Colors.white70 : const Color(0x3338BDF8),
                  ),
                  boxShadow: [
                    if (_isHovered)
                      BoxShadow(
                        color: AppColors.cyanAccent.withValues(alpha: 0.5),
                        blurRadius: 16,
                      ),
                  ],
                ),
                child: Icon(
                  widget.item.icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                widget.item.title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),

              // Tagline
              Text(
                widget.item.tagline,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.cyanAccent,
                ),
              ),
              const SizedBox(height: 12),

              // Description
              Text(
                widget.item.description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.55,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 20),

              // Tech chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.item.tags.map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF051022),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0x2238BDF8)),
                    ),
                    child: Text(
                      tag,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFBAE6FD),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Action link
              Row(
                children: [
                  Text(
                    'Discuss Project',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _isHovered ? AppColors.cyanAccent : Colors.white70,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: _isHovered ? AppColors.cyanAccent : Colors.white70,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

