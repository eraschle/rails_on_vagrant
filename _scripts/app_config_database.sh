#!/bin/bash

echo "*------------------------------------------------------------------------------"
echo "* ERSTELLE CONFIG/DATABASE.YML-Datei"
echo "*------------------------------------------------------------------------------"

# database.yml-Datei nur erstellen, wenn das Verzeichnis config existiert
if [ -d $APP_DIR/config ]; then
  cat > $APP_DIR/config/database.yml <<EOF
  # MySQL-Database configuration with environment variables

  # Default database settings
  default: &default
    adapter: mysql2
    encoding: utf8
    pool: 5
    username: root
    password: $ROOT_PW
    host: $HOST
    port: $PORT

  # Production database settings overwrites
  production:
    <<: *default
    username: $USER_DB
    password: $USER_DB_PW
    database: $PROD_DB

  # Development database settings overwrites
  development:
    <<: *default
    database: $DEV_DB

  # Test database settings overwrites
  test:
    <<: *default
    database: $TEST_DB
EOF
  echo "** DATABASE.YML erstellt"
else
  echo "** Ordner $APP_DIR/config existiert nicht"
  echo "*** DATABASE.YML NICHT erstellt"
fi