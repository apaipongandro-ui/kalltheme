@extends('layouts.app')

@section('content')
<div style="max-width:1200px;margin:0 auto;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
        <h1 style="font-size:28px;">🛡️ Protect Manager</h1>
        <span style="background:rgba(124,58,237,0.2);padding:6px 16px;border-radius:20px;color:#8b5cf6;font-weight:600;">
            🔐 Super Admin Only
        </span>
    </div>

    <div class="card" style="padding:16px 24px;margin-bottom:24px;display:flex;justify-content:space-between;align-items:center;">
        <div>
            <span style="font-weight:600;">👑 Admin Utama:</span>
            <span style="color:var(--accent-light);">{{ auth()->user()->name }}</span>
            <span style="color:var(--text-muted);font-size:14px;margin-left:12px;">(User ID: {{ auth()->user()->id }})</span>
        </div>
        <span style="color:#10b981;">✅ Akses Penuh</span>
    </div>

    <form method="POST" action="{{ route('admin.protect-manager.update') }}">
        @csrf
        @method('PUT')
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;">
            <div class="card" style="padding:20px;">
                <div style="display:flex;justify-content:space-between;align-items:center;">
                    <div>
                        <h3 style="font-size:16px;margin:0;">👁️ Anti-Intip Server</h3>
                        <p style="color:var(--text-muted);font-size:13px;margin:4px 0 0;">Sembunyikan detail server dari user biasa</p>
                    </div>
                    <label class="switch">
                        <input type="checkbox" name="anti_intip" value="1" {{ Setting::get('anti_intip', false) ? 'checked' : '' }}>
                        <span class="slider"></span>
                    </label>
                </div>
            </div>
            <div class="card" style="padding:20px;">
                <div style="display:flex;justify-content:space-between;align-items:center;">
                    <div>
                        <h3 style="font-size:16px;margin:0;">🔘 Sembunyikan Tombol</h3>
                        <p style="color:var(--text-muted);font-size:13px;margin:4px 0 0;">Hanya tampilkan tombol Server & User</p>
                    </div>
                    <label class="switch">
                        <input type="checkbox" name="sembunyi_tombol" value="1" {{ Setting::get('sembunyi_tombol', false) ? 'checked' : '' }}>
                        <span class="slider"></span>
                    </label>
                </div>
            </div>
            <div class="card" style="padding:20px;">
                <div style="display:flex;justify-content:space-between;align-items:center;">
                    <div>
                        <h3 style="font-size:16px;margin:0;">👻 Mode Stealth</h3>
                        <p style="color:var(--text-muted);font-size:13px;margin:4px 0 0;">Sembunyikan resource usage & lokasi</p>
                    </div>
                    <label class="switch">
                        <input type="checkbox" name="stealth_mode" value="1" {{ Setting::get('stealth_mode', false) ? 'checked' : '' }}>
                        <span class="slider"></span>
                    </label>
                </div>
            </div>
            <div class="card" style="padding:20px;">
                <div style="display:flex;justify-content:space-between;align-items:center;">
                    <div>
                        <h3 style="font-size:16px;margin:0;">🔒 Dashboard Lock</h3>
                        <p style="color:var(--text-muted);font-size:13px;margin:4px 0 0;">Kunci dashboard untuk user biasa</p>
                    </div>
                    <label class="switch">
                        <input type="checkbox" name="dashboard_lock" value="1" {{ Setting::get('dashboard_lock', false) ? 'checked' : '' }}>
                        <span class="slider"></span>
                    </label>
                </div>
            </div>
        </div>
        <div style="margin-top:24px;">
            <button type="submit" class="btn-primary" style="padding:12px 32px;font-size:16px;">💾 Simpan Pengaturan</button>
        </div>
    </form>

    <div class="card" style="padding:20px;margin-top:24px;background:rgba(124,58,237,0.08);border:1px solid rgba(124,58,237,0.15);">
        <h4 style="color:var(--accent-light);margin:0 0 8px;">ℹ️ Informasi Proteksi</h4>
        <ul style="color:var(--text-muted);font-size:14px;margin:0;padding-left:20px;">
            <li><strong>Anti-Intip:</strong> User biasa hanya melihat servernya sendiri.</li>
            <li><strong>Sembunyikan Tombol:</strong> Tombol "Create", "Edit", "Delete" disembunyikan dari user biasa.</li>
            <li><strong>Mode Stealth:</strong> Resource usage (CPU/RAM) tidak terlihat oleh user biasa.</li>
            <li><strong>Dashboard Lock:</strong> User biasa tidak bisa melihat statistik global.</li>
            <li><strong>Hanya Admin (ID 1):</strong> Halaman ini hanya bisa diakses oleh Admin Utama.</li>
        </ul>
    </div>
</div>
@endsection
