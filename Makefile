

make run:
	uv run python assistant.py

chat:
	uv run streamlit run app.py

network:
	docker network create monitoring

postgres: 
	docker run -it \
		--name course-assistant-pg \
		--network monitoring \
		-e POSTGRES_USER=user \
		-e POSTGRES_PASSWORD=password \
		-e POSTGRES_DB=course_assistant \
		-p 5432:5432 \
		-v pgdata:/var/lib/postgresql/data \
		postgres:17

pgadmin: 
	docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="root" \
    -e PGADMIN_CONFIG_PROXY_X_PROTO_COUNT="1" \
    -e PGADMIN_CONFIG_PROXY_X_HOST_COUNT="1" \
    -e PGADMIN_CONFIG_PROXY_X_PORT_COUNT="1" \
    -e PGADMIN_CONFIG_WTF_CSRF_SSL_STRICT="False" \
    -v pgadmin_data:/var/lib/pgadmin \
    -p 8085:80 \
    --network monitoring \
    --name pgadmin \
    dpage/pgadmin4:8.1

grafana:
	docker run -d \
    --name grafana \
    --network monitoring \
    -p 3000:3000 \
    -v grafana_data:/var/lib/grafana \
    grafana/grafana


query:
	uv run python db_query.py