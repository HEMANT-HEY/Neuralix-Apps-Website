import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/code_background.dart';
import 'widgets/navbar.dart';
import 'widgets/hero_section.dart';
import 'widgets/stats_section.dart';
import 'widgets/services_section.dart';
import 'widgets/about_owner_section.dart';
import 'widgets/testimonials_section.dart';
import 'widgets/contact_form_section.dart';
import 'widgets/footer_section.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NeuralixApp());
}

class NeuralixApp extends StatelessWidget {
  const NeuralixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neuralix Apps Solutions | IT Freelancing & Software Development',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 500 && !_showBackToTop) {
        setState(() => _showBackToTop = true);
      } else if (_scrollController.offset <= 500 && _showBackToTop) {
        setState(() => _showBackToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CodeBackground(
        child: Stack(
          children: [
            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Gap for sticky navbar
                    const SizedBox(height: 80),

                    // Hero Section
                    HeroSection(
                      onContactTap: () => _scrollTo(_contactKey),
                      onExploreTap: () => _scrollTo(_servicesKey),
                    ),

                    // Stats Bar
                    const StatsSection(),

                    // Core Services
                    Container(
                      key: _servicesKey,
                      child: ServicesSection(
                        onSelectService: () => _scrollTo(_contactKey),
                      ),
                    ),

                    // About Owner Mr. Hemant Lakhara & Dedicated Team
                    Container(
                      key: _aboutKey,
                      child: AboutOwnerSection(
                        onContactTap: () => _scrollTo(_contactKey),
                      ),
                    ),

                    // 20+ Delivered Projects & Customer Reviews
                    Container(
                      key: _portfolioKey,
                      child: Container(
                        key: _reviewsKey,
                        child: const TestimonialsSection(),
                      ),
                    ),

                    // Project Inquiry Form
                    Container(
                      key: _contactKey,
                      child: const ContactFormSection(),
                    ),

                    // Footer
                    FooterSection(
                      onServicesTap: () => _scrollTo(_servicesKey),
                      onAboutTap: () => _scrollTo(_aboutKey),
                      onPortfolioTap: () => _scrollTo(_portfolioKey),
                      onContactTap: () => _scrollTo(_contactKey),
                    ),
                  ],
                ),
              ),
            ),

            // Top Sticky Navbar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Navbar(
                onServicesTap: () => _scrollTo(_servicesKey),
                onAboutTap: () => _scrollTo(_aboutKey),
                onPortfolioTap: () => _scrollTo(_portfolioKey),
                onReviewsTap: () => _scrollTo(_reviewsKey),
                onContactTap: () => _scrollTo(_contactKey),
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: _showBackToTop
          ? FloatingActionButton.small(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              tooltip: 'Back to Top',
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward_rounded),
            )
          : null,
    );
  }
}
