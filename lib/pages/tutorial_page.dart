import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<TutorialStep> _steps = [
    TutorialStep(
      title: 'Yangi Loyiha Yaratish',
      description:
          "Asosiy oynadagi 'Yangi loyiha' tugmasini bosing. Sizga bo'sh loyiha, tizimga kirish yoki portfolio kabi tayyor shablonlardan birini tanlang.",
      blockColor: const Color(0xFFF5A623),
      icon: Icons.add_circle_outline,
      blockPreview: _buildBlockPreview([
        _BlockData('<!DOCTYPE html>', const Color(0xFFF5A623), 'document'),
        _BlockData('head', const Color(0xFFE8732A), 'head'),
        _BlockData('body', const Color(0xFFE8732A), 'body'),
      ]),
    ),
    TutorialStep(
      title: 'Bloklarni Yig\'ish',
      description:
          "Blockly muhitida chap tomondagi menyudan kerakli bloklarni (Sahifa, Tuzilma, Matn, JS, CSS) tortib oling va bir-biriga ulang. Xuddi Lego o'ynagandek!",
      blockColor: const Color(0xFFE8732A),
      icon: Icons.extension,
      blockPreview: _buildBlockPreview([
        _BlockData('div', const Color(0xFFE8732A), 'div'),
        _BlockData('...', const Color(0xFF4285F4), 'nested'),
      ]),
    ),
    TutorialStep(
      title: 'Natijani Ko\'rish',
      description:
          "'Preview' tugmasini bosish orqali yig'gan bloklaringiz qanday veb-saytga aylanganini darhol ko'rishingiz mumkin.",
      blockColor: const Color(0xFF4285F4),
      icon: Icons.play_arrow_rounded,
      blockPreview: _buildBlockPreview([
        _BlockData('Sahifa', const Color(0xFF4285F4), 'preview'),
      ]),
    ),
    TutorialStep(
      title: 'Kodni Ko\'rish',
      description:
          "HTML yoki fayllar bo'limidan yig'ilgan bloklarning asl HTML, CSS yoki JS kodlarini ham ko'rib turishingiz mumkin.",
      blockColor: const Color(0xFF34A853),
      icon: Icons.code,
      blockPreview: _buildBlockPreview([
        _BlockData('HTML', const Color(0xFF34A853), 'html'),
        _BlockData('CSS', const Color(0xFFE74C3C), 'css'),
        _BlockData('JS', const Color(0xFFF5A623), 'js'),
      ]),
    ),
    TutorialStep(
      title: 'Loyihani Saqlash',
      description:
          "Barcha loyihalar telefoningizda Documents/WebBlocks/Projects jildida lokal ravishda xavfsiz saqlanadi.",
      blockColor: const Color(0xFF27AE60),
      icon: Icons.save_alt,
      blockPreview: _buildBlockPreview([
        _BlockData('project.json', const Color(0xFF27AE60), 'save'),
      ]),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildProgressIndicator(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  return _buildStepContent(_steps[index], index);
                },
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Color(0xFF1A73E8),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'WebBlocks Qo\'llanma',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A73E8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: List.generate(_steps.length, (index) {
          final isActive = index <= _currentPage;
          final isCurrent = index == _currentPage;
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 4,
              decoration: BoxDecoration(
                color: isActive
                    ? _steps[index].blockColor
                    : const Color(0xFFDADCE0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent(TutorialStep step, int index) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step number badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: step.blockColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Qadam ${index + 1}/${_steps.length}',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: step.blockColor,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: step.blockColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(step.icon, color: step.blockColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  step.title,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF202124),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Block preview visualization
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: step.blockColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5F56),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFBD2E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF27C93F),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'blockly editor',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                step.blockPreview,
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Description
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFDADCE0)),
            ),
            child: Text(
              step.description,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: const Color(0xFF5F6368),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Orqaga'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFFDADCE0)),
                  foregroundColor: const Color(0xFF5F6368),
                ),
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                if (_currentPage < _steps.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(_currentPage < _steps.length - 1
                  ? Icons.arrow_forward
                  : Icons.check),
              label: Text(
                  _currentPage < _steps.length - 1 ? 'Keyingi' : 'Tugallash'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: const Color(0xFF1A73E8),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildBlockPreview(List<_BlockData> blocks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks.map((block) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: block.color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: block.color.withOpacity(0.4),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                block.text,
                style: GoogleFonts.robotoMono(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class TutorialStep {
  final String title;
  final String description;
  final Color blockColor;
  final IconData icon;
  final Widget blockPreview;

  TutorialStep({
    required this.title,
    required this.description,
    required this.blockColor,
    required this.icon,
    required this.blockPreview,
  });
}

class _BlockData {
  final String text;
  final Color color;
  final String type;

  _BlockData(this.text, this.color, this.type);
}
