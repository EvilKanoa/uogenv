#!/bin/bash
set -e

useradd -m -d /home/student -G ssh student -s /bin/bash
echo "student:student" | chpasswd
echo "PATH=\"/usr/local/bin:/usr/bin:/bin:/usr/sbin\"" >> /home/student/.profile

echo "student ALL=NOPASSWD:/bin/rm" >> /etc/sudoers
echo "student ALL=NOPASSWD:/bin/mkdir" >> /etc/sudoers
echo "student ALL=NOPASSWD:/bin/chown" >> /etc/sudoers
echo "student ALL=NOPASSWD:/bin/su" >> /etc/sudoers

exec "$@"

