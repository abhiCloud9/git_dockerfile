FROM ubuntu

# Install SSH server and update packages
RUN apt update && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends tzdata
RUN apt-get install -y openssh-server
RUN apt-get upgrade -y 
RUN apt -y install nano lsof nginx
RUN rm -rf /var/lib/apt/lists/*

ADD start_server.sh /
RUN chmod +rx start_server.sh
COPY sshd_config /etc/ssh/

# Set SSH environment variables
ENV SSH_PASSWD "root:Docker!"
RUN echo "$SSH_PASSWD" | chpasswd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config



# Expose port 2222 & 80 for SSH
EXPOSE 2222 80

# Running the Server
CMD /start_server.sh ; sleep infinity
