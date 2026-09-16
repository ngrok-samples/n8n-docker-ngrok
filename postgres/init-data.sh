#!/bin/bash
set -e

if [ -n "${POSTGRES_NON_ROOT_USER:-}" ] && [ -n "${POSTGRES_NON_ROOT_PASSWORD:-}" ]; then
	psql -v ON_ERROR_STOP=1 \
		--username "$POSTGRES_USER" \
		--dbname "$POSTGRES_DB" \
		--set=n8n_database="$POSTGRES_DB" \
		--set=n8n_user="$POSTGRES_NON_ROOT_USER" \
		--set=n8n_password="$POSTGRES_NON_ROOT_PASSWORD" <<-EOSQL
		CREATE USER :"n8n_user" WITH PASSWORD :'n8n_password';
		GRANT ALL PRIVILEGES ON DATABASE :"n8n_database" TO :"n8n_user";
		GRANT CREATE ON SCHEMA public TO :"n8n_user";
	EOSQL
else
	echo "SETUP INFO: No environment variables given!"
fi
