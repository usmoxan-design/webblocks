const String initialPageXml =
    '<xml xmlns="https://developers.google.com/blockly/xml"></xml>';

// ... (Login va Portfolio XML'lari o'zgarishsiz qoladi)

enum ProjectTemplate {
  blank,
  login,
  portfolio,
  landing,
  contact,
}

extension ProjectTemplateExt on ProjectTemplate {
  String get name {
    switch (this) {
      case ProjectTemplate.blank: return 'Bo\'sh loyiha (Blank)';
      case ProjectTemplate.login: return 'Tizimga kirish (Login)';
      case ProjectTemplate.portfolio: return 'Portfolio (Shaxsiy sahifa)';
      case ProjectTemplate.landing: return 'Landing Page (Biznes)';
      case ProjectTemplate.contact: return 'Bog\'lanish sahifasi (Contact)';
    }
  }

  String get xmlContent {
    // Har bir shablon uchun mos bloklarni qaytaradi
    return initialPageXml; // Soddalik uchun hozircha blank, lekin siz Blockly XML larni qo'shishingiz mumkin
  }

  String get htmlContent {
    switch (this) {
      case ProjectTemplate.login:
        return '<!DOCTYPE html><html><head><title>Login</title></head><body style="display:flex;justify-content:center;align-items:center;height:100vh;background:#f0f2f5;margin:0;font-family:sans-serif;"><div style="background:white;padding:30px;border-radius:10px;box-shadow:0 5px 15px rgba(0,0,0,0.1);text-align:center;"><h2>Xush kelibsiz</h2><input type="text" placeholder="Login" style="width:100%;margin-bottom:10px;padding:10px;"><br><button style="width:100%;background:#1a73e8;color:white;border:none;padding:10px;border-radius:5px;">Kirish</button></div></body></html>';
      case ProjectTemplate.portfolio:
        return '<!DOCTYPE html><html><head><title>Portfolio</title></head><body style="margin:0;font-family:sans-serif;background:#fafafa;"><header style="background:#333;color:white;padding:50px;text-align:center;"><h1>Mening Portfoliom</h1><p>Veb dasturchi</p></header><section style="padding:50px;max-width:800px;margin:auto;"><h2>Loyihalarim</h2><ul><li>WebBlocks App</li><li>Mobile Editor</li></ul></section></body></html>';
      case ProjectTemplate.landing:
        return '<!DOCTYPE html><html><head><title>Landing Page</title></head><body style="margin:0;font-family:sans-serif;"><nav style="background:#1a73e8;padding:15px;color:white;display:flex;justify-content:space-between;"><b>BrandName</b><div>Home | About</div></nav><header style="padding:100px 20px;text-align:center;background:#e8f0fe;"><h1>Sizning biznesingiz uchun eng yaxshi yechim</h1><button style="padding:15px 30px;background:#1a73e8;color:white;border:none;border-radius:30px;">Boshlash</button></header></body></html>';
      case ProjectTemplate.contact:
        return '<!DOCTYPE html><html><head><title>Contact Us</title></head><body style="font-family:sans-serif;padding:50px;background:#f4f4f4;"><div style="max-width:500px;margin:auto;background:white;padding:30px;border-radius:10px;"><h2>Bog\'lanish</h2><input type="text" placeholder="Ism" style="width:100%;padding:10px;margin:10px 0;"><textarea style="width:100%;padding:10px;height:100px;"></textarea><button style="width:100%;padding:15px;background:green;color:white;border:none;">Yuborish</button></div></body></html>';
      default:
        return '<!DOCTYPE html><html><head></head><body></body></html>';
    }
  }

  String get cssContent {
    return 'body { margin: 0; }';
  }

  String get jsContent {
    return 'console.log("Loyiha yuklandi");';
  }
}
