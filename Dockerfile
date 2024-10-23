FROM mhart/alpine-node
COPY . /index
CMD node /index/index.js
EXPOSE 3700
