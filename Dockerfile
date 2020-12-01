FROM node:12-alpine as SOURCES

#Create app directory
RUN mkdir /app
WORKDIR /app
COPY . /app

ENV PATH /app/node_modules/.bin:$PATH


# Install app dependencies
RUN yarn install --production
ENV INLINE_RUNTIME_CHUNK=false
RUN yarn build


# Build
FROM nginx:alpine
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=sources ./app/build /usr/share/nginx/html
