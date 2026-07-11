@extends('layouts.app')

@section('content')
<div class="login-wrapper">
    <div class="login-card card">
        <h2 style="text-align:center;margin-bottom:24px;">📝 Register</h2>
        @if($errors->any())
            <div style="background:rgba(239,68,68,0.15);border:1px solid rgba(239,68,68,0.3);padding:12px;border-radius:8px;margin-bottom:16px;color:#ef4444;">
                @foreach($errors->all() as $error)
                    <div>{{ $error }}</div>
                @endforeach
            </div>
        @endif
        <form method="POST" action="{{ route('register') }}">
            @csrf
            <div style="margin-bottom:16px;">
                <label style="display:block;margin-bottom:6px;color:var(--text-muted);font-weight:500;">Username</label>
                <input type="text" name="username" value="{{ old('username') }}" required>
            </div>
            <div style="margin-bottom:16px;">
                <label style="display:block;margin-bottom:6px;color:var(--text-muted);font-weight:500;">Email</label>
                <input type="email" name="email" value="{{ old('email') }}" required>
            </div>
            <div style="margin-bottom:16px;">
                <label style="display:block;margin-bottom:6px;color:var(--text-muted);font-weight:500;">Password</label>
                <input type="password" name="password" required>
            </div>
            <div style="margin-bottom:20px;">
                <label style="display:block;margin-bottom:6px;color:var(--text-muted);font-weight:500;">Confirm Password</label>
                <input type="password" name="password_confirmation" required>
            </div>
            <button type="submit" class="btn-primary" style="width:100%;">Register</button>
        </form>
        <div style="text-align:center;margin-top:16px;color:var(--text-muted);font-size:14px;">
            Already have account? <a href="{{ route('login') }}">Login</a>
        </div>
    </div>
</div>
@endsection
