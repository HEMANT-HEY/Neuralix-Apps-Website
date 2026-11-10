import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;

    final reviews = [
      _ReviewItem(
        name: 'Marcus Sterling',
        role: 'CEO & Founder, Sterling Tech',
        location: 'California, United States',
        avatarColor: const Color(0xFF3B82F6),
        stars: 5,
        review:
            'Mr. Hemant Lakhara and the Neuralix team delivered our cross-platform mobile app two weeks ahead of schedule. The code cleanliness, fluid UI animations, and transparent daily updates were phenomenal. Finding an overseas IT team this trusted is rare.',
        projectType: 'Mobile App Development (iOS & Android)',
      ),
      _ReviewItem(
        name: 'Sophie Laurent',
        role: 'Head of Product, Horizon Cloud',
        location: 'Paris, France',
        avatarColor: const Color(0xFF8B5CF6),
        stars: 5,
        review:
            'Neuralix Apps Solutions engineered our entire SaaS dashboard and client portal from scratch. Their UI/UX sensibility is top tier, and their backend architecture easily handles our growing user traffic. Highly recommended!',
        projectType: 'Full-Stack Web Application',
      ),
      _ReviewItem(
        name: 'David Miller',
        role: 'Managing Director, Apex Fleet',
        location: 'Sydney, Australia',
        avatarColor: const Color(0xFF10B981),
        stars: 5,
        review:
            'We have collaborated with Neuralix on three separate software projects. Hemant’s ability to combine a dedicated team with individual problem-solving skills saved us thousands of dollars in tech debt. True professionals.',
        projectType: 'Custom Software & Realtime Telemetry',
      ),
      _ReviewItem(
        name: 'Amir Al-Mansoor',
        role: 'VP Operations, Gulf FinTech',
        location: 'Dubai, UAE',
        avatarColor: const Color(0xFFF59E0B),
        stars: 5,
        review:
            'Their digital growth advisory and modern web development boosted our online conversion by over 160%. Communication across time zones was seamless, and deliverables were spotless.',
        projectType: 'Web Portal & Digital Scaling',
      ),
    ];

    final portfolioHighlights = [
      _ProjectItem('OmniPay Global', 'Cross-Platform FinTech App', 'USA', 'Flutter & Node.js'),
      _ProjectItem('MedixPulse', 'Telehealth Patient Portal', 'UK', 'Web & Mobile App'),
      _ProjectItem('CargoTrace AI', 'Real-Time Logistics Dashboard', 'Germany', 'Custom Software'),
      _ProjectItem('Elevate Commerce', 'D2C Scalable Storefront', 'Australia', 'React & Cloud'),
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
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0x2238BDF8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x4438BDF8)),
                ),
                child: Text(
                  'GLOBAL TRACK RECORD',
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
                'Trusted by Foreign Clients Worldwide',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 26 : 38,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  'Over 20+ successful web and mobile applications delivered for international startups, enterprises, and visionary entrepreneurs.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Portfolio Highlights Strip
              LayoutBuilder(
                builder: (context, constraints) {
                  final double itemWidth = constraints.maxWidth > 900
                      ? (constraints.maxWidth - 48) / 4
                      : constraints.maxWidth > 600
                          ? (constraints.maxWidth - 16) / 2
                          : constraints.maxWidth;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: portfolioHighlights.map((item) {
                      return SizedBox(
                        width: itemWidth,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF09162D),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0x2238BDF8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.country,
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.cyanAccent,
                                    ),
                                  ),
                                  const Icon(Icons.public_rounded,
                                      size: 14, color: AppColors.cyanAccent),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.type,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF061022),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item.tech,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 48),

              // Reviews Section Subtitle
              Text(
                'What Foreign Clients Say About Neuralix',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Reviews Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final double cardWidth = constraints.maxWidth > 850
                      ? (constraints.maxWidth - 24) / 2
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: reviews.map((rev) {
                      return SizedBox(
                        width: cardWidth,
                        child: _ReviewCard(review: rev),
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

class _ProjectItem {
  final String title;
  final String type;
  final String country;
  final String tech;

  _ProjectItem(this.title, this.type, this.country, this.tech);
}

class _ReviewItem {
  final String name;
  final String role;
  final String location;
  final Color avatarColor;
  final int stars;
  final String review;
  final String projectType;

  _ReviewItem({
    required this.name,
    required this.role,
    required this.location,
    required this.avatarColor,
    required this.stars,
    required this.review,
    required this.projectType,
  });
}

class _ReviewCard extends StatelessWidget {
  final _ReviewItem review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFF091733),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x2238BDF8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Client Avatar & Stars
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: review.avatarColor,
                child: Text(
                  review.name.substring(0, 1),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${review.role} • ${review.location}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.cyanAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  review.stars,
                  (index) => const Icon(Icons.star_rounded, size: 18, color: Color(0xFFFBBF24)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Project Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0x2200D2FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              review.projectType,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF7DD3FC),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Review Body
          Text(
            '"${review.review}"',
            style: GoogleFonts.inter(
              fontSize: 13.5,
              height: 1.6,
              color: AppColors.textWhite,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

