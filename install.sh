#!/bin/bash
# ============================================================
# KALL XTREME X - NEBULA PRO THEME INSTALLER
# Auto-generate semua file + install ke Pterodactyl
# ============================================================

echo "🔥 NEBULA PRO THEME - INSTALLER"
echo "================================================"
echo ""

# Path Pterodactyl
PTERO_PATH="/var/www/pterodactyl"

# Cek apakah Pterodactyl ada
if [ ! -d "$PTERO_PATH" ]; then
    echo "❌ ERROR: Pterodactyl gak ketemu di $PTERO_PATH"
    exit 1
fi

# Backup views
echo "📦 Backup original views..."
BACKUP_DIR="$PTERO_PATH/resources/views-backup-$(date +%Y%m%d-%H%M%S)"
cp -r "$PTERO_PATH/resources/views" "$BACKUP_DIR"
echo "✅ Backup berhasil: $BACKUP_DIR"

# ============================================================
# COPY FILE TEMA KE PTERODACTYL
# ============================================================
echo "🎨 Deploying theme files..."

# Copy semua folder ke resources/views
cp -rf theme/layouts "$PTERO_PATH/resources/views/"
cp -rf theme/auth "$PTERO_PATH/resources/views/"
cp -rf theme/server "$PTERO_PATH/resources/views/"
cp -rf theme/admin "$PTERO_PATH/resources/views/"

# Copy assets ke public
cp -rf theme/assets/* "$PTERO_PATH/public/assets/"

# ============================================================
# SET PERMISSION YANG BENER
# ============================================================
echo "🔒 Setting permissions..."
chown -R www-data:www-data "$PTERO_PATH/resources/views/"
chown -R www-data:www-data "$PTERO_PATH/public/assets/"
chmod -R 755 "$PTERO_PATH/resources/views/"
chmod -R 644 "$PTERO_PATH/public/assets/css/"*.css
chmod -R 644 "$PTERO_PATH/public/assets/js/"*.js

# ============================================================
# INJEK CSS KE APP.CSS
# ============================================================
echo "🎨 Injecting CSS ke app.css..."
echo "@import '/assets/css/nebula.css';" >> "$PTERO_PATH/public/assets/css/app.css"
echo "@import '/assets/css/protection.css';" >> "$PTERO_PATH/public/assets/css/app.css"

# ============================================================
# CLEAR CACHE TOTAL
# ============================================================
echo "🧹 Clearing cache..."
cd "$PTERO_PATH"
php artisan view:clear
php artisan cache:clear
php artisan config:clear
php artisan optimize:clear

# ============================================================
# RESTART SERVICE
# ============================================================
echo "🔄 Restarting services..."
systemctl restart nginx
systemctl restart php8.1-fpm 2>/dev/null || true
systemctl restart php8.2-fpm 2>/dev/null || true
systemctl restart pterodactyl-panel

echo ""
echo "================================================"
echo "✅ INSTALLATION COMPLETE!"
echo "🎯 Theme: NEBULA PRO"
echo "📌 Backup: $BACKUP_DIR"
echo "================================================"
echo ""
echo "🚀 BUKA BROWSER: https://domain-anda.com"
echo "🔄 JANGAN LUPA HARD REFRESH (Ctrl+F5)"
echo ""
