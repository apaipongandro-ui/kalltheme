<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Nebula Pro - {{ config('app.name', 'Pterodactyl') }}</title>
    <link rel="stylesheet" href="/assets/css/nebula.css">
    <link rel="stylesheet" href="/assets/css/protection.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="icon" href="/assets/images/logo.png">
</head>
<body>
    <div id="app">
        <nav class="navbar" style="display:flex;justify-content:space-between;align-items:center;">
            <div style="display:flex;align-items:center;gap:20px;">
                <a href="/" style="font-size:20px;font-weight:700;color:var(--accent-light);text-decoration:none;">NEBULA</a>
                <a href="{{ route('servers.index') }}" style="color:var(--text);text-decoration:none;">🚀 Servers</a>
                <a href="{{ route('users.index') }}" style="color:var(--text);text-decoration:none;">👤 Users</a>
                @if(auth()->check() && auth()->user()->id === 1)
                    <a href="{{ route('admin.dashboard') }}" style="color:var(--text);text-decoration:none;">⚡ Admin</a>
                    <a href="{{ route('admin.protect-manager') }}" style="color:var(--accent-light);text-decoration:none;font-weight:600;">🛡️ Protect</a>
                @endif
            </div>
            <div style="display:flex;align-items:center;gap:12px;">
                <span style="color:var(--text-muted);font-size:14px;">
                    @auth
                        {{ auth()->user()->name }}
                        @if(auth()->user()->id === 1)
                            <span style="background:rgba(124,58,237,0.3);padding:2px 10px;border-radius:12px;font-size:11px;color:#8b5cf6;">ADMIN</span>
                        @endif
                    @endauth
                </span>
                <a href="{{ route('logout') }}" style="color:var(--text-muted);font-size:13px;text-decoration:none;">Logout</a>
            </div>
        </nav>
        <main style="padding:24px;">
            @yield('content')
        </main>
    </div>
    <script src="/assets/js/nebula.js"></script>
    <script src="/assets/js/security.js"></script>
    <script src="/assets/js/protect-manager.js"></script>
    @stack('scripts')
</body>
</html>
