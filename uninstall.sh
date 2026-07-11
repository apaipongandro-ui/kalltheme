#!/bin/bash
# ============================================================
# UNINSTALL - Balikin ke tema default Pterodactyl
# ============================================================

echo "🔄 UNINSTALL NEBULA THEME"
echo "================================================"

PTERO_PATH="/var/www/pterodactyl"

BACKUP_DIR=$(ls -td "$PTERO_PATH/resources/views-backup-"* 2>/dev/null | head -1)

if [ -z "$BACKUP_DIR" ]; then
    echo "❌ Gak ada backup ditemukan!"
    echo "   Hapus manual? (y/n)"
    read -r confirm
    if [ "$confirm" != "y" ]; then
        exit 1
    fi
    rm -rf "$PTERO_PATH/resources/views/"*
    echo "✅ Views dihapus manual."
else
    echo "📦 Restore dari: $BACKUP_DIR"
    rm -rf "$PTERO_PATH/resources/views/"*
    cp -r "$BACKUP_DIR"/* "$PTERO_PATH/resources/views/"
    echo "✅ Backup berhasil direstore."
fi

# Hapus assets tema
rm -f "$PTERO_PATH/public/assets/css/nebula.css"
rm -f "$PTERO_PATH/public/assets/css/protection.css"
rm -f "$PTERO_PATH/public/assets/js/nebula.js"
rm -f "$PTERO_PATH/public/assets/js/security.js"
rm -f "$PTERO_PATH/public/assets/js/protect-manager.js"

# Bersihin app.css
cd "$PTERO_PATH"
sed -i '/@import .*nebula.css/d' public/assets/css/app.css
sed -i '/@import .*protection.css/d' public/assets/css/app.css

php artisan view:clear
php artisan cache:clear
php artisan config:clear

systemctl restart nginx php8.1-fpm

echo "✅ UNINSTALL COMPLETE! Tema balik ke default."
