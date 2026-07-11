@extends('layouts.app')

@section('content')
<div class="login-wrapper">
    <div class="login-card card">
        <h2 style="text-align:center;margin-bottom:16px;">🔑 Reset Password</h2>
        <p style="color:var(--text-muted);text-align:center;font-size:14px;margin-bottom:24px;">Masukkan email lo, kami akan kirim link reset password.</p>
        @if (session('status'))
            <div style="background:rgba(16,185,129,0.2);border:1px solid rgba(16,185,129,0.3);padding:12px;border-radius:8px;margin-bottom:16px;color:#10b981;">{{ session('status') }}</div>
        @endif
        <form method="POST" action="{{ route('password.email') }}">
            @csrf
            <div style="margin-bottom:16px;">
                <label style="display:block;margin-bottom:6px;color:var(--text-muted);font-weight:500;">Email</label>
                <input type="email" name="email" value="{{ old('email') }}" required>
            </div>
            <button type="submit" class="btn-primary" style="width:100%;">Send Reset Link</button>
        </form>
        <div style="text-align:center;margin-top:16px;">
            <a href="{{ route('login') }}" style="font-size:14px;">← Back to login</a>
        </div>
    </div>
</div>
@endsection
