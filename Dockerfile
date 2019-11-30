FROM nginx:1.17-alpine

RUN apk update && apk add erlang erlang-inets erlang-runtime-tools 

# Set exposed ports
EXPOSE 80
ENV PORT=80

COPY doc /usr/share/nginx/html
COPY mars_explorer /app/mars_explorer
COPY start.sh /app/start.sh

ENTRYPOINT ["app/start.sh"]

