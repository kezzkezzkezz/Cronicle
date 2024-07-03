# Use the official Node.js image as the base image
FROM node:14

# Set environment variables
ENV CRONICLE_base_dir=/opt/cronicle
ENV CRONICLE_HOME=/opt/cronicle

# Create the Cronicle directory
RUN mkdir -p /opt/cronicle

# Change to the Cronicle directory
WORKDIR /opt/cronicle

# Download and extract Cronicle
RUN curl -L https://github.com/jhuckaby/Cronicle/archive/v1.0.0.tar.gz | tar zxvf - --strip-components 1

# Install Cronicle dependencies
RUN npm install

# Build Cronicle distribution
RUN node bin/build.js dist

# Copy default config
RUN cp /opt/cronicle/config.sample.json /opt/cronicle/conf/config.json

# Expose the necessary port
EXPOSE 3012

# Start Cronicle
CMD ["node", "bin/run.js"]
