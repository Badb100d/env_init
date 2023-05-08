#!/bin/bash
# check if character special file hwrng exists.
if [ -c /dev/hwrng ];then
    GENPASSWD="[ 0 -eq \$(id -u) ] && alias genpasswd=\"strings /dev/hwrng | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n';echo\" || alias genpasswd=\"strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n';echo\""
else
    GENPASSWD="alias genpasswd=\"strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n';echo\""
fi
#DOCKER_RC="if [ \$\$ == 1 ]; then
#    nohup /etc/rc.local  >>/var/log/rc.log 2>&1 &
#fi"
cat <<EOF >> /etc/bash.bashrc
export HISTTIMEFORMAT="%y/%m/%d %T "
$GENPASSWD
extract() {
         if [ -f \$1 ] ; then
                 case \$1 in
                         *.tar.bz2)   tar xjf \$1     ;;
     			 *.tar.gz)    tar xzf \$1     ;;
     			 *.bz2)       bunzip2 \$1     ;;
     			 *.rar)       unrar e \$1     ;;
     			 *.gz)        gunzip \$1      ;;
     			 *.tar)       tar xf \$1      ;;
     			 *.tbz2)      tar xjf \$1     ;;
     			 *.tgz)       tar xzf \$1     ;;
     			 *.zip)       unzip \$1       ;;
     			 *.Z)         uncompress \$1  ;;
     			 *.7z)        7z x \$1        ;;
     			 *)     echo "'\$1' cannot be extracted via extract()" ;;
         	esac
         else
                echo "'\$1' is not a valid file"
	fi
}
alias cmount="mount|column -t"
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e '/|/'"
diskusg() { du -b --max-depth 1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", \$1>=2**30? (\$1/2**30, "G"): \$1>=2**20? (\$1/2**20, "M"): \$1>=2**10? (\$1/2**10, "K"): (\$1, "") }e'|column -t;}
alias meminfo='free -m -l -t'
alias ps?="ps -ef|grep"
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"
alias wttr="curl wttr.in"
alias ll='ls -lF --color=auto'
alias la='ls -la --color=auto'
alias grep='grep --color=auto'
alias vim='vim -b'
EOF
