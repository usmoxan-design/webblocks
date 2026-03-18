const String initialPageXml =
    '<xml xmlns="https://developers.google.com/blockly/xml"></xml>';

// ... (Login va Portfolio XML'lari o'zgarishsiz qoladi)

enum ProjectTemplate {
  blank,
  login,
  portfolio,
  landing,
  contact,
  blog,
  shop,
}

extension ProjectTemplateExt on ProjectTemplate {
  String get name {
    switch (this) {
      case ProjectTemplate.blank:
        return 'Bo\'sh loyiha (Blank)';
      case ProjectTemplate.login:
        return 'Tizimga kirish (Login)';
      case ProjectTemplate.portfolio:
        return 'Portfolio (Shaxsiy sahifa)';
      case ProjectTemplate.landing:
        return 'Landing Page (Biznes)';
      case ProjectTemplate.contact:
        return 'Bog\'lanish sahifasi (Contact)';
      case ProjectTemplate.blog:
        return 'Blog Sahifasi';
      case ProjectTemplate.shop:
        return 'E-komers (Shop)';
    }
  }

  String get xmlContent {
    switch (this) {
      case ProjectTemplate.login:
        return '''<xml xmlns="https://developers.google.com/blockly/xml">
  <block type="html_document" x="20" y="20">
    <statement name="CONTENT">
      <block type="html_head">
        <statement name="CONTENT">
          <block type="html_title">
            <field name="TITLE">Login</field>
          </block>
        </statement>
        <next>
          <block type="html_body">
            <value name="ATTR">
              <block type="html_attribute">
                <field name="ATTR_NAME">style</field>
                <field name="ATTR_VALUE">display:flex;justify-content:center;align-items:center;height:100vh;background:#f0f2f5;margin:0;font-family:sans-serif;</field>
              </block>
            </value>
            <statement name="CONTENT">
              <block type="html_div">
                <value name="ATTR">
                  <block type="html_attribute">
                    <field name="ATTR_NAME">style</field>
                    <field name="ATTR_VALUE">background:white;padding:30px;border-radius:10px;box-shadow:0 5px 15px rgba(0,0,0,0.1);text-align:center;</field>
                  </block>
                </value>
                <statement name="CONTENT">
                  <block type="html_custom_code">
                    <field name="CODE">&lt;h2&gt;Xush kelibsiz&lt;/h2&gt;</field>
                    <next>
                      <block type="html_custom_code">
                        <field name="CODE">&lt;input type="text" placeholder="Login" style="width:100%;margin-bottom:10px;padding:10px;"&gt;&lt;br&gt;</field>
                        <next>
                          <block type="html_custom_code">
                            <field name="CODE">&lt;button style="width:100%;background:#1a73e8;color:white;border:none;padding:10px;border-radius:5px;"&gt;Kirish&lt;/button&gt;</field>
                          </block>
                        </next>
                      </block>
                    </next>
                  </block>
                </statement>
              </block>
            </statement>
          </block>
        </next>
      </block>
    </statement>
  </block>
</xml>''';
      case ProjectTemplate.portfolio:
        return '''<xml xmlns="https://developers.google.com/blockly/xml">
  <block type="html_document" x="20" y="20">
    <statement name="CONTENT">
      <block type="html_head">
        <statement name="CONTENT">
          <block type="html_title">
            <field name="TITLE">Portfolio</field>
          </block>
        </statement>
        <next>
          <block type="html_body">
            <value name="ATTR">
              <block type="html_attribute">
                <field name="ATTR_NAME">style</field>
                <field name="ATTR_VALUE">margin:0;font-family:sans-serif;background:#fafafa;</field>
              </block>
            </value>
            <statement name="CONTENT">
              <block type="html_custom_code">
                <field name="CODE">&lt;header style="background:#333;color:white;padding:50px;text-align:center;"&gt;&lt;h1&gt;Mening Portfoliom&lt;/h1&gt;&lt;p&gt;Veb dasturchi&lt;/p&gt;&lt;/header&gt;</field>
                <next>
                  <block type="html_section">
                    <value name="ATTR">
                      <block type="html_attribute">
                        <field name="ATTR_NAME">style</field>
                        <field name="ATTR_VALUE">padding:50px;max-width:800px;margin:auto;</field>
                      </block>
                    </value>
                    <statement name="CONTENT">
                      <block type="html_custom_code">
                        <field name="CODE">&lt;h2&gt;Loyihalarim&lt;/h2&gt;</field>
                        <next>
                          <block type="html_ul">
                            <statement name="CONTENT">
                              <block type="html_li">
                                <statement name="CONTENT">
                                  <block type="html_text_node">
                                    <field name="TEXT">WebBlocks App</field>
                                  </block>
                                </statement>
                                <next>
                                  <block type="html_li">
                                    <statement name="CONTENT">
                                      <block type="html_text_node">
                                        <field name="TEXT">Mobile Editor</field>
                                      </block>
                                    </statement>
                                  </block>
                                </next>
                              </block>
                            </statement>
                          </block>
                        </next>
                      </block>
                    </statement>
                  </block>
                </next>
              </block>
            </statement>
          </block>
        </next>
      </block>
    </statement>
  </block>
</xml>''';
      case ProjectTemplate.landing:
        return '''<xml xmlns="https://developers.google.com/blockly/xml">
  <block type="html_document" x="20" y="20">
    <statement name="CONTENT">
      <block type="html_head">
        <statement name="CONTENT">
          <block type="html_title">
            <field name="TITLE">Landing Page</field>
          </block>
        </statement>
        <next>
          <block type="html_body">
            <value name="ATTR">
              <block type="html_attribute">
                <field name="ATTR_NAME">style</field>
                <field name="ATTR_VALUE">margin:0;font-family:sans-serif;</field>
              </block>
            </value>
            <statement name="CONTENT">
              <block type="html_custom_code">
                <field name="CODE">&lt;nav style="background:#1a73e8;padding:15px;color:white;display:flex;justify-content:space-between;"&gt;&lt;b&gt;BrandName&lt;/b&gt;&lt;div&gt;Home | About&lt;/div&gt;&lt;/nav&gt;</field>
                <next>
                  <block type="html_custom_code">
                    <field name="CODE">&lt;header style="padding:100px 20px;text-align:center;background:#e8f0fe;"&gt;&lt;h1&gt;Sizning biznesingiz uchun eng yaxshi yechim&lt;/h1&gt;&lt;button style="padding:15px 30px;background:#1a73e8;color:white;border:none;border-radius:30px;"&gt;Boshlash&lt;/button&gt;&lt;/header&gt;</field>
                  </block>
                </next>
              </block>
            </statement>
          </block>
        </next>
      </block>
    </statement>
  </block>
</xml>''';
      case ProjectTemplate.contact:
        return '''<xml xmlns="https://developers.google.com/blockly/xml">
  <block type="html_document" x="20" y="20">
    <statement name="CONTENT">
      <block type="html_head">
        <statement name="CONTENT">
          <block type="html_title">
            <field name="TITLE">Contact Us</field>
          </block>
        </statement>
        <next>
          <block type="html_body">
            <value name="ATTR">
              <block type="html_attribute">
                <field name="ATTR_NAME">style</field>
                <field name="ATTR_VALUE">font-family:sans-serif;padding:50px;background:#f4f4f4;</field>
              </block>
            </value>
            <statement name="CONTENT">
              <block type="html_div">
                <value name="ATTR">
                  <block type="html_attribute">
                    <field name="ATTR_NAME">style</field>
                    <field name="ATTR_VALUE">max-width:500px;margin:auto;background:white;padding:30px;border-radius:10px;</field>
                  </block>
                </value>
                <statement name="CONTENT">
                  <block type="html_custom_code">
                    <field name="CODE">&lt;h2&gt;Bog'lanish&lt;/h2&gt;&lt;input type="text" placeholder="Ism" style="width:100%;padding:10px;margin:10px 0;"&gt;</field>
                    <next>
                      <block type="html_custom_code">
                        <field name="CODE">&lt;textarea style="width:100%;padding:10px;height:100px;"&gt;&lt;/textarea&gt;</field>
                        <next>
                          <block type="html_button">
                            <value name="ATTR">
                              <block type="html_attribute">
                                <field name="ATTR_NAME">style</field>
                                <field name="ATTR_VALUE">width:100%;padding:15px;background:green;color:white;border:none;</field>
                              </block>
                            </value>
                            <statement name="CONTENT">
                              <block type="html_text_node">
                                <field name="TEXT">Yuborish</field>
                              </block>
                            </statement>
                          </block>
                        </next>
                      </block>
                    </next>
                  </block>
                </statement>
              </block>
            </statement>
          </block>
        </next>
      </block>
    </statement>
  </block>
</xml>''';
      case ProjectTemplate.blog:
        return '''<xml xmlns="https://developers.google.com/blockly/xml">
  <block type="html_document" x="20" y="20">
    <statement name="CONTENT">
      <block type="html_head">
        <statement name="CONTENT">
          <block type="html_title">
            <field name="TITLE">Blog Sahifasi</field>
          </block>
        </statement>
        <next>
          <block type="html_body">
            <value name="ATTR">
              <block type="html_attribute">
                <field name="ATTR_NAME">style</field>
                <field name="ATTR_VALUE">margin:0;font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;background:#f8f9fa;color:#333;line-height:1.6;</field>
              </block>
            </value>
            <statement name="CONTENT">
              <block type="html_custom_code">
                <field name="CODE">&lt;header style="background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);color:white;padding:60px 20px;text-align:center;"&gt;&lt;h1 style="margin:0;font-size:3rem;"&gt;Mening Blogim&lt;/h1&gt;&lt;p style="margin:10px 0 0;font-size:1.2rem;opacity:0.9;"&gt;Dasturlash va texnologiyalar haqida maqolalar&lt;/p&gt;&lt;/header&gt;</field>
                <next>
                  <block type="html_div">
                    <value name="ATTR">
                      <block type="html_attribute">
                        <field name="ATTR_NAME">style</field>
                        <field name="ATTR_VALUE">max-width:800px;margin:40px auto;padding:0 20px;display:grid;grid-template-columns:1fr;gap:30px;</field>
                      </block>
                    </value>
                    <statement name="CONTENT">
                      <block type="html_custom_code">
                        <field name="CODE">&lt;article style="background:white;border-radius:10px;box-shadow:0 2px 15px rgba(0,0,0,0.1);padding:30px;transition:transform 0.3s ease,box-shadow 0.3s ease;"&gt;&lt;div style="color:#667eea;font-size:0.9rem;font-weight:bold;margin-bottom:10px;"&gt;MAY 15, 2024 • WEB DASTURLASH&lt;/div&gt;&lt;h2 style="margin:10px 0 15px;color:#2c3e50;font-size:2rem;"&gt;Flutter'da Responsive Dizayn&lt;/h2&gt;&lt;p style="color:#555;margin-bottom:20px;"&gt;Flutter'da responsive dizayn qanday qilib amalga oshiriladi? Bu maqolada MediaQuery, LayoutBuilder va Flexible widget'laridan foydalanishni o'rganamiz...&lt;/p&gt;&lt;a href="#" style="color:#667eea;text-decoration:none;font-weight:bold;display:inline-flex;align-items:center;gap:8px;transition:gap 0.3s ease;"&gt;Batafsil &gt;&lt;/a&gt;&lt;/article&gt;</field>
                        <next>
                          <block type="html_custom_code">
                            <field name="CODE">&lt;article style="background:white;border-radius:10px;box-shadow:0 2px 15px rgba(0,0,0,0.1);padding:30px;transition:transform 0.3s ease,box-shadow 0.3s ease;"&gt;&lt;div style="color:#667eea;font-size:0.9rem;font-weight:bold;margin-bottom:10px;"&gt;MAY 10, 2024 • DATABASE&lt;/div&gt;&lt;h2 style="margin:10px 0 15px;color:#2c3e50;font-size:2rem;"&gt;Firebase Cloud Firestore&lt;/h2&gt;&lt;p style="color:#555;margin-bottom:20px;"&gt;NoSQL ma'lumotlar bazasi sifatida Cloud Firestore'niki afzalliklari va qo'llash usullari. Real-time sinxronizatsiya va offline rejim...&lt;/p&gt;&lt;a href="#" style="color:#667eea;text-decoration:none;font-weight:bold;display:inline-flex;align-items:center;gap:8px;transition:gap 0.3s ease;"&gt;Batafsil &gt;&lt;/a&gt;&lt;/article&gt;</field>
                            <next>
                              <block type="html_custom_code">
                                <field name="CODE">&lt;article style="background:white;border-radius:10px;box-shadow:0 2px 15px rgba(0,0,0,0.1);padding:30px;transition:transform 0.3s ease,box-shadow 0.3s ease;"&gt;&lt;div style="color:#667eea;font-size:0.9rem;font-weight:bold;margin-bottom:10px;"&gt;MAY 5, 2024 • STATE MANAGEMENT&lt;/div&gt;&lt;h2 style="margin:10px 0 15px;color:#2c3e50;font-size:2rem;"&gt;Provider vs Bloc&lt;/h2&gt;&lt;p style="color:#555;margin-bottom:20px;"&gt;Flutter'da state management uchun eng mashhur usullarni taqqoslash. Providerning oddiyligi va Blocning skaliyatsiyasi...&lt;/p&gt;&lt;a href="#" style="color:#667eea;text-decoration:none;font-weight:bold;display:inline-flex;align-items:center;gap:8px;transition:gap 0.3s ease;"&gt;Batafsil &gt;&lt;/a&gt;&lt;/article&gt;</field>
                              </block>
                            </next>
                          </block>
                        </next>
                      </block>
                    </statement>
                  </block>
                </next>
              </block>
            </statement>
          </block>
        </next>
      </block>
    </statement>
  </block>
</xml>''';
      case ProjectTemplate.shop:
        return '''<xml xmlns="https://developers.google.com/blockly/xml">
  <block type="html_document" x="20" y="20">
    <statement name="CONTENT">
      <block type="html_head">
        <statement name="CONTENT">
          <block type="html_title">
            <field name="TITLE">Shop</field>
          </block>
        </statement>
        <next>
          <block type="html_body">
            <value name="ATTR">
              <block type="html_attribute">
                <field name="ATTR_NAME">style</field>
                <field name="ATTR_VALUE">margin:0;font-family:sans-serif;background:#f5f5f5;</field>
              </block>
            </value>
            <statement name="CONTENT">
              <block type="html_custom_code">
                <field name="CODE"><header style="background:#1a73e8;color:white;padding:20px;text-align:center;"><h1>Mening Do'konim</h1></header><div style="padding:20px;max-width:1200px;margin:auto;"><h2>Mahsulotlar</h2><p>Bu yerda mahsulotlar ko'rsatiladi.</p></div></field>
              </block>
            </statement>
          </block>
        </next>
      </block>
    </statement>
  </block>
</xml>''';
      default:
        return '<xml xmlns="https://developers.google.com/blockly/xml"><block type="html_document" x="20" y="20"><statement name="CONTENT"><block type="html_head"><statement name="CONTENT"><block type="html_title"><field name="TITLE">Bo\'sh Sahifa</field></block></statement><next><block type="html_body"><statement name="CONTENT"><block type="html_h1"><field name="TEXT">Salom Dunyo!</field></block></statement></block></next></block></statement></block></xml>';
    }
  }

  String get htmlContent {
    switch (this) {
      case ProjectTemplate.login:
        return '<html><head><title>Login</title></head><body style="display:flex;justify-content:center;align-items:center;height:100vh;background:#f0f2f5;margin:0;font-family:sans-serif;"><div style="background:white;padding:30px;border-radius:10px;box-shadow:0 5px 15px rgba(0,0,0,0.1);text-align:center;"><h2>Xush kelibsiz</h2><input type="text" placeholder="Login" style="width:100%;margin-bottom:10px;padding:10px;"><br><button style="width:100%;background:#1a73e8;color:white;border:none;padding:10px;border-radius:5px;">Kirish</button></div></body></html>';
      case ProjectTemplate.portfolio:
        return '<html><head><title>Portfolio</title></head><body style="margin:0;font-family:sans-serif;background:#fafafa;"><header style="background:#333;color:white;padding:50px;text-align:center;"><h1>Mening Portfoliom</h1><p>Veb dasturchi</p></header><section style="padding:50px;max-width:800px;margin:auto;"><h2>Loyihalarim</h2><ul><li>WebBlocks App</li><li>Mobile Editor</li></ul></section></body></html>';
      case ProjectTemplate.landing:
        return '<html><head><title>Landing Page</title></head><body style="margin:0;font-family:sans-serif;"><nav style="background:#1a73e8;padding:15px;color:white;display:flex;justify-content:space-between;"><b>BrandName</b><div>Home | About</div></nav><header style="padding:100px 20px;text-align:center;background:#e8f0fe;"><h1>Sizning biznesingiz uchun eng yaxshi yechim</h1><button style="padding:15px 30px;background:#1a73e8;color:white;border:none;border-radius:30px;">Boshlash</button></header></body></html>';
      case ProjectTemplate.contact:
        return '<html><head><title>Contact Us</title></head><body style="font-family:sans-serif;padding:50px;background:#f4f4f4;"><div style="max-width:500px;margin:auto;background:white;padding:30px;border-radius:10px;"><h2>Bog\'lanish</h2><input type="text" placeholder="Ism" style="width:100%;padding:10px;margin:10px 0;"><textarea style="width:100%;padding:10px;height:100px;"></textarea><button style="width:100%;padding:15px;background:green;color:white;border:none;">Yuborish</button></div></body></html>';
      case ProjectTemplate.blog:
        return '<html><head><title>Blog Sahifasi</title></head><body style="margin:0;font-family:\'Segoe UI\',Tahoma,Geneva,Verdana,sans-serif;background:#f8f9fa;color:#333;line-height:1.6;"><header style="background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);color:white;padding:60px 20px;text-align:center;"><h1 style="margin:0;font-size:3rem;">Mening Blogim</h1><p style="margin:10px 0 0;font-size:1.2rem;opacity:0.9;">Dasturlash va texnologiyalar haqida maqolalar</p></header><div style="max-width:800px;margin:40px auto;padding:0 20px;display:grid;grid-template-columns:1fr;gap:30px;"><article style="background:white;border-radius:10px;box-shadow:0 2px 15px rgba(0,0,0,0.1);padding:30px;transition:transform 0.3s ease,box-shadow 0.3s ease;"><div style="color:#667eea;font-size:0.9rem;font-weight:bold;margin-bottom:10px;">MAY 15, 2024 • WEB DASTURLASH</div><h2 style="margin:10px 0 15px;color:#2c3e50;font-size:2rem;">Flutter\'da Responsive Dizayn</h2><p style="color:#555;margin-bottom:20px;">Flutter\'da responsive dizayn qanday qilib amalga oshiriladi? Bu maqolada MediaQuery, LayoutBuilder va Flexible widget\'laridan foydalanishni o\'rganamiz...</p><a href="#" style="color:#667eea;text-decoration:none;font-weight:bold;display:inline-flex;align-items:center;gap:8px;transition:gap 0.3s ease;">Batafsil ></a></article><article style="background:white;border-radius:10px;box-shadow:0 2px 15px rgba(0,0,0,0.1);padding:30px;transition:transform 0.3s ease,box-shadow 0.3s ease;"><div style="color:#667eea;font-size:0.9rem;font-weight:bold;margin-bottom:10px;">MAY 10, 2024 • DATABASE</div><h2 style="margin:10px 0 15px;color:#2c3e50;font-size:2rem;">Firebase Cloud Firestore</h2><p style="color:#555;margin-bottom:20px;">NoSQL ma\'lumotlar bazasi sifatida Cloud Firestore\'niki afzalliklari va qo\'llash usullari. Real-time sinxronizatsiya va offline rejim...</p><a href="#" style="color:#667eea;text-decoration:none;font-weight:bold;display:inline-flex;align-items:center;gap:8px;transition:gap 0.3s ease;">Batafsil ></a></article><article style="background:white;border-radius:10px;box-shadow:0 2px 15px rgba(0,0,0,0.1);padding:30px;transition:transform 0.3s ease,box-shadow 0.3s ease;"><div style="color:#667eea;font-size:0.9rem;font-weight:bold;margin-bottom:10px;">MAY 5, 2024 • STATE MANAGEMENT</div><h2 style="margin:10px 0 15px;color:#2c3e50;font-size:2rem;">Provider vs Bloc</h2><p style="color:#555;margin-bottom:20px;">Flutter\'da state management uchun eng mashhur usullarni taqqoslash. Providerning oddiyligi va Blocning skaliyatsiyasi...</p><a href="#" style="color:#667eea;text-decoration:none;font-weight:bold;display:inline-flex;align-items:center;gap:8px;transition:gap 0.3s ease;">Batafsil ></a></article></div></body></html>';
      case ProjectTemplate.shop:
        return '<html><head><title>Shop</title></head><body style="margin:0;font-family:sans-serif;background:#f5f5f5;"><header style="background:#1a73e8;color:white;padding:20px;text-align:center;"><h1>Mening Do\'konim</h1></header><div style="padding:20px;max-width:1200px;margin:auto;"><h2>Mahsulotlar</h2><p>Bu yerda mahsulotlar ko\'rsatiladi.</p></div></body></html>';
      default:
        return '<html><head></head><body></body></html>';
    }
  }

  String get cssXmlContent {
    return '''<xml xmlns="https://developers.google.com/blockly/xml">
  <block type="css_selector" x="20" y="20">
    <field name="SELECTOR">body</field>
    <statement name="RULES">
      <block type="css_property">
        <field name="PROP">margin</field>
        <field name="VALUE">0</field>
      </block>
    </statement>
  </block>
</xml>''';
  }

  String get jsXmlContent {
    return '''<xml xmlns="https://developers.google.com/blockly/xml">
  <block type="js_console_log" x="20" y="20">
    <field name="TEXT">Loyiha yuklandi</field>
  </block>
</xml>''';
  }

  String get cssContent {
    return 'body { margin: 0; }';
  }

  String get jsContent {
    return 'console.log("Loyiha yuklandi");';
  }
}
