@extends('layouts.app')

@section('content')
<div style="max-width:1200px;margin:0 auto;">
    <h1 style="font-size:28px;margin-bottom:24px;">⚡ Admin Dashboard</h1>
    <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:16px;margin-bottom:24px;">
        <div class="card" style="padding:20px;text-align:center;">
            <div style="font-size:32px;font-weight:700;color:var(--accent-light);">{{ $stats->servers ?? 0 }}</div>
            <div style="color:var(--text-muted);font-size:14px;">Total Servers</div>
        </div>
        <div class="card" style="padding:20px;text-align:center;">
            <div style="font-size:32px;font-weight:700;color:var(--accent-light);">{{ $stats->users ?? 0 }}</div>
            <div style="color:var(--text-muted);font-size:14px;">Total Users</div>
        </div>
        <div class="card" style="padding:20px;text-align:center;">
            <div style="font-size:32px;font-weight:700;color:var(--accent-light);">{{ $stats->nodes ?? 0 }}</div>
            <div style="color:var(--text-muted);font-size:14px;">Total Nodes</div>
        </div>
        <div class="card" style="padding:20px;text-align:center;">
            <div style="font-size:32px;font-weight:700;color:var(--accent-light);">{{ $stats->locations ?? 0 }}</div>
            <div style="color:var(--text-muted);font-size:14px;">Locations</div>
        </div>
    </div>
    <div class="card" style="padding:20px;">
        <h3 style="margin-bottom:12px;">📊 Recent Activity</h3>
        <p style="color:var(--text-muted);">Log aktivitas terbaru akan muncul di sini...</p>
    </div>
</div>
@endsection
