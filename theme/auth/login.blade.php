@extends('layouts.app')

@section('content')
<div class="login-wrapper">
    <div class="login-card card">
        <div style="text-align:center;margin-bottom:30px;">
            <h1 style="font-size:28px;font-weight:700;background:linear-gradient(135deg,#7c3aed,#8b5cf6);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">NEBULA</h1>
            <p style="color:var(--text-muted);margin-top:4px;">Dark Theme • Pro Edition</p>
        </div>
        @if(session('error'))
            <div style="background:rgba(239,68,68,0.15);border:1px solid rgba(239,68,68,0.3);padding:12px;border-radius:8px;margin-bottom:16px;color:#ef4444;">{{ session('error') }}</div>
        @endif
        <form method="POST" action="{{ route('login') }}">
            @csrf
            <div style="margin-bottom:16px;">
                <label style="display:block;margin-bottom:6px;color:var(--text-muted);font-weight:500;">Email</label>
                <input type="email" name="email" value="{{ old('email') }}" required autofocus>
            </div>
            <div style="margin-bottom:16px;">
                <label style="display:block;margin-bottom:6px;color:var(--text-muted);font-weight:500;">Password</label>
                <input type="password" name="password" required>
            </div>
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
                <label style="color:var(--text-muted);font-size:14px;display:flex;align-items:center;gap:6px;">
                    <input type="checkbox" name="remember"> Remember me
                </label>
                <a href="{{ route('password.request') }}" style="font-size:14px;">Forgot password?</a>
            </div>
            <button type="submit" class="btn-primary" style="width:100%;">Login</button>
        </form>
        <div style="text-align:center;margin-top:16px;color:var(--text-muted);font-size:14px;">
            Don't have account? <a href="{{ route('register') }}">Register</a>
        </div>
    </div>
</div>
@endsection
