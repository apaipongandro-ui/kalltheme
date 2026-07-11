@extends('layouts.app')

@section('content')
<div style="max-width:1200px;margin:0 auto;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
        <h1 style="font-size:28px;">🚀 Server List</h1>
        @if(auth()->user()->id === 1)
            <button class="btn-primary">+ Create Server</button>
        @endif
    </div>
    <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:20px;">
        @forelse($servers ?? [] as $server)
            @if(auth()->user()->id === 1 || $server->owner_id === auth()->user()->id)
                <div class="server-card card" style="padding:20px;">
                    <div style="display:flex;justify-content:space-between;align-items:start;">
                        <h3 style="font-size:18px;margin:0;">{{ $server->name }}</h3>
                        <span class="status-online" style="font-size:12px;">● Online</span>
                    </div>
                    <p style="color:var(--text-muted);font-size:14px;margin:8px 0 0;">{{ $server->description ?? 'No description' }}</p>
                    @if(auth()->user()->id === 1)
                        <div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">
                            <span style="background:rgba(124,58,237,0.2);padding:4px 12px;border-radius:20px;font-size:12px;">CPU: 25%</span>
                            <span style="background:rgba(124,58,237,0.2);padding:4px 12px;border-radius:20px;font-size:12px;">RAM: 512MB</span>
                        </div>
                    @else
                        <div style="margin-top:12px;color:var(--text-muted);font-size:12px;font-style:italic;">🔒 Detail server dilindungi</div>
                    @endif
                </div>
            @endif
        @empty
            <div class="card" style="padding:40px;text-align:center;grid-column:1/-1;">
                <p style="color:var(--text-muted);">Belum ada server. Buat server pertama lo!</p>
            </div>
        @endforelse
    </div>
</div>
@endsection
