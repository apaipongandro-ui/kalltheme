#!/bin/bash
# ============================================================
# KALL XTREME X - NEBULA PRO THEME INSTALLER (FIXED)
# ============================================================

echo "🔥 NEBULA PRO THEME - INSTALLER"
echo "================================================"
echo ""

PTERO_PATH="/var/www/pterodactyl"

if [ ! -d "$PTERO_PATH" ]; then
    echo "❌ ERROR: Pterodactyl gak ketemu di $PTERO_PATH"
    echo "   Pastikan Pterodactyl udah terinstall!"
    exit 1
fi

# Backup
echo "📦 Backup original views..."
BACKUP_DIR="$PTERO_PATH/resources/views-backup-$(date +%Y%m%d-%H%M%S)"
cp -r "$PTERO_PATH/resources/views" "$BACKUP_DIR"
echo "✅ Backup berhasil: $BACKUP_DIR"

# Bikin folder theme/assets dulu (biar gak error)
mkdir -p theme/assets/css
mkdir -p theme/assets/js
mkdir -p theme/assets/images
mkdir -p theme/layouts
mkdir -p theme/auth/passwords
mkdir -p theme/server
mkdir -p theme/admin

# ============================================================
# GENERATE FILE CSS
# ============================================================
cat > theme/assets/css/nebula.css << 'EOF'
:root {
  --primary: #0a0a0f;
  --secondary: #1a0b2e;
  --accent: #7c3aed;
  --accent-light: #8b5cf6;
  --gradient: linear-gradient(135deg, #0a0a0f 0%, #1a0b2e 50%, #2d1b4e 100%);
  --text: #e2d9f3;
  --text-muted: #9a8ab8;
  --card-bg: rgba(26, 11, 46, 0.85);
  --border-glow: rgba(124, 58, 237, 0.3);
}
body { background: var(--gradient); color: var(--text); font-family: 'Inter', sans-serif; min-height: 100vh; margin: 0; }
.card, .server-card { background: var(--card-bg); backdrop-filter: blur(12px); border: 1px solid var(--border-glow); border-radius: 16px; padding: 20px; transition: all 0.3s; }
.card:hover { transform: translateY(-4px); box-shadow: 0 12px 48px rgba(124,58,237,0.3); }
.btn-primary { background: linear-gradient(135deg, #7c3aed, #8b5cf6); border: none; color: #fff; padding: 10px 24px; border-radius: 8px; font-weight: 600; cursor: pointer; }
.btn-primary:hover { transform: scale(1.05); box-shadow: 0 0 30px rgba(124,58,237,0.5); }
.navbar { background: rgba(10,10,15,0.8) !important; backdrop-filter: blur(16px); border-bottom: 1px solid var(--border-glow); padding: 12px 24px; display: flex; justify-content: space-between; align-items: center; }
input, select, textarea { background: rgba(10,10,15,0.6) !important; border: 1px solid var(--border-glow) !important; color: var(--text) !important; border-radius: 8px !important; padding: 10px 14px !important; width: 100%; box-sizing: border-box; }
input:focus { border-color: #7c3aed !important; box-shadow: 0 0 20px rgba(124,58,237,0.2) !important; outline: none !important; }
.login-wrapper { display: flex; justify-content: center; align-items: center; min-height: 100vh; background: var(--gradient); }
.login-card { max-width: 420px; width: 100%; padding: 40px; }
a { color: #8b5cf6; text-decoration: none; }
a:hover { color: #7c3aed; text-decoration: underline; }
.status-online { color: #10b981 !important; }
h1, h2, h3 { color: var(--text); font-weight: 700; }
EOF

cat > theme/assets/css/protection.css << 'EOF'
.badge-security { background: rgba(124,58,237,0.2); border: 1px solid rgba(124,58,237,0.3); color: #8b5cf6; border-radius: 20px; padding: 2px 12px; font-size: 11px; }
.switch { position: relative; display: inline-block; width: 50px; height: 28px; }
.switch input { opacity: 0; width: 0; height: 0; }
.slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background: #4a4a5a; border-radius: 34px; transition: .3s; }
.slider:before { content: ""; position: absolute; height: 20px; width: 20px; left: 4px; bottom: 4px; background-color: white; border-radius: 50%; transition: .3s; }
input:checked + .slider { background: #7c3aed; }
input:checked + .slider:before { transform: translateX(22px); }
EOF

# ============================================================
# GENERATE FILE JS
# ============================================================
cat > theme/assets/js/nebula.js << 'EOF'
(function() {
  const c = document.createElement('canvas');
  c.style.cssText = 'position:fixed;top:0;left:0;width:100%;height:100%;z-index:-1;pointer-events:none';
  document.body.prepend(c);
  const ctx = c.getContext('2d');
  let w, h;
  function resize() { w = c.width = window.innerWidth; h = c.height = window.innerHeight; }
  resize();
  window.addEventListener('resize', resize);
  const particles = [];
  for (let i = 0; i < 80; i++) {
    particles.push({
      x: Math.random() * w,
      y: Math.random() * h,
      size: Math.random() * 3 + 1,
      speedX: (Math.random() - 0.5) * 0.5,
      speedY: (Math.random() - 0.5) * 0.5,
      color: `hsl(${270 + Math.random() * 30}, 70%, ${50 + Math.random() * 30}%)`
    });
  }
  function draw() {
    ctx.clearRect(0, 0, w, h);
    particles.forEach(p => {
      p.x += p.speedX; p.y += p.speedY;
      if (p.x < 0 || p.x > w) p.speedX *= -1;
      if (p.y < 0 || p.y > h) p.speedY *= -1;
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
      ctx.fillStyle = p.color;
      ctx.shadowColor = '#7c3aed';
      ctx.shadowBlur = 20;
      ctx.fill();
    });
    requestAnimationFrame(draw);
  }
  draw();
})();
EOF

cat > theme/assets/js/security.js << 'EOF'
(function() {
  function getFingerprint() {
    const ua = navigator.userAgent;
    const res = `${screen.width}x${screen.height}`;
    const tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
    const lang = navigator.language;
    return btoa(`${ua}|${res}|${tz}|${lang}`);
  }
  console.log('🔒 Security active');
  document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('form').forEach(f => f.setAttribute('data-protected', 'true'));
  });
})();
EOF

cat > theme/assets/js/protect-manager.js << 'EOF'
document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.switch input').forEach(t => {
    t.addEventListener('change', function() {
      const s = this.nextElementSibling;
      s.style.background = this.checked ? '#7c3aed' : '#4a4a5a';
    });
  });
});
EOF

# ============================================================
# GENERATE FILE BLADE
# ============================================================
cat > theme/layouts/app.blade.php << 'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="csrf-token" content="{{ csrf_token() }}">
  <title>Nebula Pro</title>
  <link rel="stylesheet" href="/assets/css/nebula.css">
  <link rel="stylesheet" href="/assets/css/protection.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
  <nav class="navbar">
    <div style="display:flex;align-items:center;gap:20px;">
      <a href="/" style="font-size:20px;font-weight:700;color:#8b5cf6;text-decoration:none;">NEBULA</a>
      <a href="{{ route('servers.index') }}" style="color:var(--text);text-decoration:none;">🚀 Servers</a>
      <a href="{{ route('users.index') }}" style="color:var(--text);text-decoration:none;">👤 Users</a>
      @if(auth()->check() && auth()->user()->id === 1)
        <a href="{{ route('admin.dashboard') }}" style="color:var(--text);text-decoration:none;">⚡ Admin</a>
        <a href="{{ route('admin.protect-manager') }}" style="color:#8b5cf6;text-decoration:none;font-weight:600;">🛡️ Protect</a>
      @endif
    </div>
    <div>
      <span style="color:var(--text-muted);font-size:14px;">
        @auth {{ auth()->user()->name }} @if(auth()->user()->id === 1) <span style="background:rgba(124,58,237,0.3);padding:2px 10px;border-radius:12px;font-size:11px;color:#8b5cf6;">ADMIN</span> @endif @endauth
      </span>
      <a href="{{ route('logout') }}" style="color:var(--text-muted);font-size:13px;text-decoration:none;margin-left:12px;">Logout</a>
    </div>
  </nav>
  <main style="padding:24px;">@yield('content')</main>
  <script src="/assets/js/nebula.js"></script>
  <script src="/assets/js/security.js"></script>
  <script src="/assets/js/protect-manager.js"></script>
  @stack('scripts')
</body>
</html>
EOF

cat > theme/auth/login.blade.php << 'EOF'
@extends('layouts.app')
@section('content')
<div class="login-wrapper">
  <div class="login-card card">
    <h1 style="text-align:center;font-size:28px;background:linear-gradient(135deg,#7c3aed,#8b5cf6);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">NEBULA</h1>
    <p style="text-align:center;color:var(--text-muted);">Dark Theme • Pro Edition</p>
    @if(session('error'))<div style="background:rgba(239,68,68,0.15);padding:12px;border-radius:8px;margin:16px 0;color:#ef4444;">{{ session('error') }}</div>@endif
    <form method="POST" action="{{ route('login') }}">
      @csrf
      <div style="margin-bottom:16px;"><label style="color:var(--text-muted);">Email</label><input type="email" name="email" required></div>
      <div style="margin-bottom:16px;"><label style="color:var(--text-muted);">Password</label><input type="password" name="password" required></div>
      <div style="display:flex;justify-content:space-between;margin-bottom:20px;">
        <label style="color:var(--text-muted);font-size:14px;"><input type="checkbox" name="remember"> Remember me</label>
        <a href="{{ route('password.request') }}">Forgot password?</a>
      </div>
      <button type="submit" class="btn-primary" style="width:100%;">Login</button>
    </form>
    <div style="text-align:center;margin-top:16px;color:var(--text-muted);">Don't have account? <a href="{{ route('register') }}">Register</a></div>
  </div>
</div>
@endsection
EOF

cat > theme/auth/register.blade.php << 'EOF'
@extends('layouts.app')
@section('content')
<div class="login-wrapper">
  <div class="login-card card">
    <h2 style="text-align:center;">📝 Register</h2>
    @if($errors->any())<div style="background:rgba(239,68,68,0.15);padding:12px;border-radius:8px;margin-bottom:16px;color:#ef4444;">@foreach($errors->all() as $e)<div>{{ $e }}</div>@endforeach</div>@endif
    <form method="POST" action="{{ route('register') }}">
      @csrf
      <div style="margin-bottom:16px;"><label style="color:var(--text-muted);">Username</label><input type="text" name="username" required></div>
      <div style="margin-bottom:16px;"><label style="color:var(--text-muted);">Email</label><input type="email" name="email" required></div>
      <div style="margin-bottom:16px;"><label style="color:var(--text-muted);">Password</label><input type="password" name="password" required></div>
      <div style="margin-bottom:20px;"><label style="color:var(--text-muted);">Confirm Password</label><input type="password" name="password_confirmation" required></div>
      <button type="submit" class="btn-primary" style="width:100%;">Register</button>
    </form>
    <div style="text-align:center;margin-top:16px;color:var(--text-muted);">Already have account? <a href="{{ route('login') }}">Login</a></div>
  </div>
</div>
@endsection
EOF

cat > theme/auth/passwords/email.blade.php << 'EOF'
@extends('layouts.app')
@section('content')
<div class="login-wrapper">
  <div class="login-card card">
    <h2 style="text-align:center;">🔑 Reset Password</h2>
    @if(session('status'))<div style="background:rgba(16,185,129,0.2);padding:12px;border-radius:8px;margin-bottom:16px;color:#10b981;">{{ session('status') }}</div>@endif
    <form method="POST" action="{{ route('password.email') }}">
      @csrf
      <div style="margin-bottom:16px;"><label style="color:var(--text-muted);">Email</label><input type="email" name="email" required></div>
      <button type="submit" class="btn-primary" style="width:100%;">Send Reset Link</button>
    </form>
    <div style="text-align:center;margin-top:16px;"><a href="{{ route('login') }}">← Back to login</a></div>
  </div>
</div>
@endsection
EOF

cat > theme/server/index.blade.php << 'EOF'
@extends('layouts.app')
@section('content')
<div style="max-width:1200px;margin:0 auto;">
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
    <h1 style="font-size:28px;">🚀 Server List</h1>
    @if(auth()->user()->id === 1)<button class="btn-primary">+ Create Server</button>@endif
  </div>
  <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:20px;">
    @forelse($servers ?? [] as $server)
      @if(auth()->user()->id === 1 || $server->owner_id === auth()->user()->id)
        <div class="server-card card">
          <div style="display:flex;justify-content:space-between;">
            <h3 style="margin:0;">{{ $server->name }}</h3>
            <span class="status-online">● Online</span>
          </div>
          <p style="color:var(--text-muted);">{{ $server->description ?? 'No description' }}</p>
          @if(auth()->user()->id === 1)
            <div style="display:flex;gap:8px;flex-wrap:wrap;">
              <span style="background:rgba(124,58,237,0.2);padding:4px 12px;border-radius:20px;font-size:12px;">CPU: 25%</span>
              <span style="background:rgba(124,58,237,0.2);padding:4px 12px;border-radius:20px;font-size:12px;">RAM: 512MB</span>
            </div>
          @else
            <div style="color:var(--text-muted);font-size:12px;font-style:italic;">🔒 Detail dilindungi</div>
          @endif
        </div>
      @endif
    @empty
      <div class="card" style="grid-column:1/-1;text-align:center;"><p>Belum ada server.</p></div>
    @endforelse
  </div>
</div>
@endsection
EOF

cat > theme/admin/dashboard.blade.php << 'EOF'
@extends('layouts.app')
@section('content')
<div style="max-width:1200px;margin:0 auto;">
  <h1 style="font-size:28px;margin-bottom:24px;">⚡ Admin Dashboard</h1>
  <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:16px;">
    <div class="card" style="text-align:center;"><div style="font-size:32px;font-weight:700;color:#8b5cf6;">{{ $stats->servers ?? 0 }}</div><div style="color:var(--text-muted);">Servers</div></div>
    <div class="card" style="text-align:center;"><div style="font-size:32px;font-weight:700;color:#8b5cf6;">{{ $stats->users ?? 0 }}</div><div style="color:var(--text-muted);">Users</div></div>
    <div class="card" style="text-align:center;"><div style="font-size:32px;font-weight:700;color:#8b5cf6;">{{ $stats->nodes ?? 0 }}</div><div style="color:var(--text-muted);">Nodes</div></div>
    <div class="card" style="text-align:center;"><div style="font-size:32px;font-weight:700;color:#8b5cf6;">{{ $stats->locations ?? 0 }}</div><div style="color:var(--text-muted);">Locations</div></div>
  </div>
</div>
@endsection
EOF

cat > theme/admin/protect-manager.blade.php << 'EOF'
@extends('layouts.app')
@section('content')
<div style="max-width:1200px;margin:0 auto;">
  <h1 style="font-size:28px;">🛡️ Protect Manager</h1>
  <span style="background:rgba(124,58,237,0.2);padding:6px 16px;border-radius:20px;color:#8b5cf6;">🔐 Super Admin Only</span>
  <div class="card" style="margin:20px 0;display:flex;justify-content:space-between;">
    <div><span>👑 Admin:</span> <span style="color:#8b5cf6;">{{ auth()->user()->name }}</span> <span style="color:var(--text-muted);">(ID: {{ auth()->user()->id }})</span></div>
    <span style="color:#10b981;">✅ Akses Penuh</span>
  </div>
  <form method="POST" action="{{ route('admin.protect-manager.update') }}">
    @csrf @method('PUT')
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;">
      <div class="card"><div style="display:flex;justify-content:space-between;"><div><h3>👁️ Anti-Intip</h3><p style="color:var(--text-muted);">Sembunyikan detail server</p></div><label class="switch"><input type="checkbox" name="anti_intip"><span class="slider"></span></label></div></div>
      <div class="card"><div style="display:flex;justify-content:space-between;"><div><h3>🔘 Sembunyi Tombol</h3><p style="color:var(--text-muted);">Hanya Server & User</p></div><label class="switch"><input type="checkbox" name="sembunyi_tombol"><span class="slider"></span></label></div></div>
      <div class="card"><div style="display:flex;justify-content:space-between;"><div><h3>👻 Mode Stealth</h3><p style="color:var(--text-muted);">Sembunyi resource usage</p></div><label class="switch"><input type="checkbox" name="stealth_mode"><span class="slider"></span></label></div></div>
      <div class="card"><div style="display:flex;justify-content:space-between;"><div><h3>🔒 Dashboard Lock</h3><p style="color:var(--text-muted);">Kunci dashboard user biasa</p></div><label class="switch"><input type="checkbox" name="dashboard_lock"><span class="slider"></span></label></div></div>
    </div>
    <button type="submit" class="btn-primary" style="margin-top:24px;padding:12px 32px;">💾 Simpan</button>
  </form>
</div>
@endsection
EOF

# ============================================================
# COPY KE PTERODACTYL
# ============================================================
echo "🎨 Copy theme ke Pterodactyl..."
cp -rf theme/layouts "$PTERO_PATH/resources/views/"
cp -rf theme/auth "$PTERO_PATH/resources/views/"
cp -rf theme/server "$PTERO_PATH/resources/views/"
cp -rf theme/admin "$PTERO_PATH/resources/views/"
cp -rf theme/assets/* "$PTERO_PATH/public/assets/"

echo "🔒 Setting permissions..."
chown -R www-data:www-data "$PTERO_PATH/resources/views/"
chown -R www-data:www-data "$PTERO_PATH/public/assets/"
chmod -R 755 "$PTERO_PATH/resources/views/"
chmod -R 644 "$PTERO_PATH/public/assets/css/"*.css
chmod -R 644 "$PTERO_PATH/public/assets/js/"*.js

echo "🧹 Clear cache..."
cd "$PTERO_PATH"
php artisan view:clear
php artisan cache:clear
php artisan config:clear

echo "🔄 Restart..."
systemctl restart nginx php8.1-fpm 2>/dev/null || true

echo ""
echo "✅ INSTALLATION COMPLETE!"
echo "🎯 Theme: NEBULA PRO"
echo "📌 Backup: $BACKUP_DIR"
echo "🚀 Buka panel: https://domain-anda.com"
echo ""
