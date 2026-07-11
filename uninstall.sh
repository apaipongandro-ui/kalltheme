#!/bin/bash
echo "🔄 UNINSTALL NEBULA THEME"
PTERO_PATH="/var/www/pterodactyl"
BACKUP=$(ls -td "$PTERO_PATH/resources/views-backup-"* 2>/dev/null | head -1)
if [ -z "$BACKUP" ]; then
    echo "❌ Gak ada backup!"
    exit 1
fi
echo "📦 Restore dari: $BACKUP"
rm -rf "$PTERO_PATH/resources/views/"*
cp -r "$BACKUP"/* "$PTERO_PATH/resources/views/"
rm -f "$PTERO_PATH/public/assets/css/nebula.css"
rm -f "$PTERO_PATH/public/assets/css/protection.css"
rm -f "$PTERO_PATH/public/assets/js/nebula.js"
rm -f "$PTERO_PATH/public/assets/js/security.js"
cd "$PTERO_PATH"
php artisan view:clear
php artisan cache:clear
systemctl restart nginx php8.1-fpm
echo "✅ UNINSTALL COMPLETE!"
