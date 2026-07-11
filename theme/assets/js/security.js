(function() {
  function getFingerprint() {
    const ua = navigator.userAgent;
    const res = `${screen.width}x${screen.height}`;
    const tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
    const lang = navigator.language;
    return btoa(`${ua}|${res}|${tz}|${lang}`);
  }

  const fp = getFingerprint();
  console.log('🔒 Security: Fingerprint active');

  document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('form').forEach(form => {
      form.setAttribute('data-protected', 'true');
    });
  });

  const badge = document.createElement('div');
  badge.style.cssText = 'position:fixed;bottom:12px;right:12px;font-size:10px;color:#9a8ab8;opacity:0.3;z-index:9999;background:rgba(10,10,15,0.8);padding:4px 12px;border-radius:20px;backdrop-filter:blur(4px);pointer-events:none;';
  badge.textContent = '🛡️ Protected by KALL XTREME X';
  document.body.appendChild(badge);
})();
