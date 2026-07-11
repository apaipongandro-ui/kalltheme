document.addEventListener('DOMContentLoaded', function() {
  const toggles = document.querySelectorAll('.switch input[type="checkbox"]');

  toggles.forEach(toggle => {
    toggle.addEventListener('change', function() {
      const slider = this.nextElementSibling;
      if (this.checked) {
        slider.style.background = '#7c3aed';
      } else {
        slider.style.background = '#4a4a5a';
      }

      const card = this.closest('.card');
      if (card) {
        card.style.transition = 'all 0.2s';
        card.style.borderColor = this.checked ? 'rgba(124, 58, 237, 0.6)' : 'rgba(124, 58, 237, 0.2)';
        setTimeout(() => {
          card.style.borderColor = '';
        }, 600);
      }
    });
  });

  console.log('🛡️ Protect Manager UI loaded');
});
