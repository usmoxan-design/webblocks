import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Qo\'llanma',
            style: GoogleFonts.inter(
                color: const Color(0xFF1A73E8), fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A73E8)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHeader('WebBlocks\'ga xush kelibsiz! 🎉', 
              'Bu ilova yordamida veb-saytlarni bloklar orqali mobil telefoningizda qura olasiz.'),
          
          _buildSection(
            icon: Icons.add_circle_outline,
            title: '1. Yangi Loyiha Yaratish',
            description: "Asosiy oynadagi 'Yangi loyiha' tugmasini bosing. Sizga bo'sh loyiha, tizimga kirish (login) yoki portfolio kabi tayyor shablonlardan birini tanlash imkoni beriladi.",
          ),
          
          _buildSection(
            icon: Icons.extension,
            title: '2. Bloklarni Yig\'ish (Qurish)',
            description: "Loyihaga kirganingizdan so'ng, Blockly muhitida chap tomondagi menyudan (Sahifa, Tuzilma, Matn, JS, CSS) kerakli bloklarni tortib oling va bir-biriga ulang. Xuddi Lego o'ynagandek!",
          ),

          _buildSection(
            icon: Icons.play_arrow_rounded,
            title: '3. Natijani Ko\'rish (Preview)',
            description: "'Preview' tugmasini bosish orqali yig'gan bloklaringiz qanday veb-saytga aylanganini darhol ko'rishingiz mumkin. Kodingiz brauzerda huddi kompyuterdagidek ishlaydi.",
          ),

          _buildSection(
            icon: Icons.code,
            title: '4. Kodni Ko\'rish',
            description: "HTML yoki fayllar bo'limidan yig'ilgan bloklarning asl HTML, CSS yoki JS kodlarini ham ko'rib turish mumkin. Bu orqali siz dasturlash tillarini osongina o'rganasiz.",
          ),
          
          _buildSection(
            icon: Icons.save_alt,
            title: '5. Loyihani Saqlash',
            description: "Barcha loyihalar telefoningizdagi Documents/WebBlocks/Projects jildida lokal ravishda xavfsiz saqlanadi. Ularni istalgan payt ko'chirib olishingiz mumkin.",
          ),
          
          const SizedBox(height: 30),
          Center(
            child: Text(
              'Omad yor bo\'lsin! 🚀',
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1A73E8)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSection({required IconData icon, required String title, required String description}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDADCE0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFE8732A), size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF5F6368), height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF1A73E8)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF1A73E8)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
