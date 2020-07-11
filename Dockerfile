FROM bash

RUN apk update && apk add --no-cache curl git ncurses perl perl-utils make
RUN ln -s /usr/local/bin/bash /bin/bash
WORKDIR /opt/
RUN git clone https://github.com/m3n0sd0n4ld/uDork
RUN yes | perl -MCPAN -e 'install URI::Escape'
WORKDIR uDork
RUN sed -i 's/c_user=HEREYOUCOOKIE/c_user=$c_user/g' uDork.sh
RUN sed -i 's/xs=HEREYOUCOOKIE/xs=$xs/g' uDork.sh
RUN chmod +x uDork.sh
ENTRYPOINT ["bash","uDork.sh"]
