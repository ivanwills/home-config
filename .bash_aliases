## Various perl searches

# find a file in specified path
# usage afind colon_seperated_path file
alias afind='perl -e "for\$p(split/:/,\$ARGV[0]){ opendir P,\$p; for(readdir P){ print \"\$p/\$_\n\"if/\$ARGV[1]/ } }"'

# search the $PATH for all occurances of argument 1
# usage: pfind file
alias pfind='perl -e "for\$p(split/:/,\$ENV{PATH}){ opendir P,\$p; for(readdir P){ print \"\$p/\$_\n\"if/\$ARGV[0]/ } }"'

# search for file names
alias gfind='find . 2> /dev/null | /bin/grep -vP "([.](svn|git|bzr)|CVS|RCS|node_modules)" | /bin/grep -P --color'
alias gffind='find . -type f 2> /dev/null | /bin/grep -vP "([.](svn|git|bzr)|CVS|RCS|node_modules)" | /bin/grep -P --color'
alias gfinda='find . 2> /dev/null | /bin/grep -vP "([.](svn|git|bzr)|CVS|RCS)" | /bin/grep -P --color'
alias gffinda='find . -type f 2> /dev/null | /bin/grep -vP "([.](svn|git|bzr)|CVS|RCS)" | /bin/grep -P --color'
alias jfind='find src 2> /dev/null | /bin/grep -vP "[.]sw[pnox]" | /bin/grep -P --color'

# search Perl's @INC for argument $1
# usage: incfind module
alias incall='find `perl -E "say join \"\n\", @INC"` -type f 2> /dev/null | grep "[.](pm|pod)\$" | sort'
alias incfind='incall | grep'

# smarten up cs
alias cs='cs --smart -x "deps/" '

# human readable directory size listing
alias size="perl -e '\$\"=\" \";for(split/\n/,`du -bs @ARGV 2>/dev/null|sort -n`){my(\$n,\$t)=/^(\\d+)\\s+(.+)\$/;my\$s=\$n<1000?\"\":\$n<1e6?\"Kb\":\$n<1e9?\"Mb\":\$n<1e12?\"Gb\":\"Tb\"; \$n/=\$n<1000?1:\$n<1e6?1e3:\$n<1e9?1e6:\$n<1e12?1e9:1e12; printf \"%2.1f\$s\t\$t\n\", \$n }'"

# Filters
alias diasvg="perl -pe 's/\s+\w+=\"[^\"]+\"//g; s{<\w+/>}{}g; s{^\s*<text>(.+)</text>}{\$1}g; s{<[^>]+>}{}g; s/^\s*\n//;'"
alias diasvgDump="perl -MData::Dumper=Dumper -e '%p;\$c; while(<>){ chomp; if(/^\\w/){\$p{\$_}={op=>[],at=>[]}; \$c=\$_}elsif(/^\\s+([^)]+[)])/){\$p{\$c}{op}[-1] .= \$1 } elsif(/\\(/){ push @{\$p{\$c}{op}},\$_ }else{push@{\$p{\$c}{at}},\$_}  } print Dumper \\%p'"
alias diasvgout="perl -e '\$d.=\$_ while(<>); \$d=eval\$d; \$t=\"itempl \"; for (sort keys %{\$d}) { \$c=\$t.(/^[A-Z]/?\"perl/package -a module=\":\"db/table -a table=\").\"\$_ -a \".(/^[A-Z]/?\"vars=,\".(join \",\",@{\$d->{\$_}{at}}).\" -a sigs=,\".(join \",\",@{\$d->{\$_}{op}}) : \"columns=,\".join \",\",@{\$d->{\$_}{at}}); \$c=~s/([\$();])/\\\\\$1/g; \$c.=\"\$c > \$_.\".(/^[A-Z]/?\"pm\":\"sql\").\"\\n\"; system(\$c)&& warn \$c }'"
alias diasvg2files="diasvg | diasvgDump | diasvgout"

## Module::Build helpers

alias build="perl Build.PL && ./Build && ./Build test && ./Build dist"
alias build-clean="perl Build.PL && ./Build && ./Build test && ./Build dist && ./Build distclean && rm Makefile.PL.~?~"

## some more ls aliases
alias ls='ls --color --ignore=.*.sw?'
alias ll='ls --color --ignore=.*.sw? -lF -h'
alias la='ls --color --ignore=.*.sw? -AF'
alias l='ls  --color --ignore=.*.sw? -lAF -h'
alias lld="ls | perl -nle 'print \$_ if -d \$_' | xargs ls -dlAF --color"
alias ils='find . 2>/dev/null | grep "~|[.]sw[nmopq]"'

## some aliases for tree
alias treepl="tree -I '_build|blib|*META*|MANIFEST*|LICENSE|Changes|cover_db|prof|node_modules|.git'"
alias treejs="tree -I 'node_modules|tmp|.git|coverage'"

## common error aliases
alias 'cd..'='cd ..'

## Other simplified commands
alias diff='diff -uN'
alias vvd='vcsvimdiff'
alias vd='vcsvimdiff -Rv'
alias v='v --title -O'
alias less='less -R'
alias logcat="perl -ple 's/\033.*?m//g; s/\07//g; s/\010//g; s/\015//g'"
logless() {
    logcat $* | less;
}

alias diffdir="diffdir -c vimdiff -m"
if [ -x `which vim.pl 2> /dev/null` ]; then
    if [ `perl -MGetopt::Alt -e '1' 2> /dev/null` ]; then
        alias vim='vim.pl --skip "target|blib|_build|tmp" --find'
    fi
fi

## Subversion aliases
alias svndiff='svn diff --diff-cmd /usr/bin/diff'
alias svnl1='svn log --limit 1'
alias svn='cmdaliaser svn'
if [ -x `which cmdaliaser 2> /dev/null` ]; then
    alias svn='cmdaliaser svn'
fi

## Bazaar
if [ -x `which cmdaliaser 2> /dev/null` ]; then
    alias bzr='cmdaliaser bzr'
fi

## GIT
if [ -x `which correct-vcs 2> /dev/null` ]; then
    # No longer sure I should to this with the problems it causes with auto-complete
    #alias git='correct-vcs'
    unalias git 2> /dev/null
fi
git-merge-fix() {
    git fmt-merge-msg < .git/FETCH_HEAD > .git/MERGE_MSG
}
alias gg="git grep"
alias ga="git ack"
alias gga="group-git ack"

## CVS
if [ -x `which cmdaliaser 2> /dev/null` ]; then
    alias cvs='cmdaliaser cvs'
    alias csv='cmdaliaser cvs'
fi

## Process info

alias pscount='ps aux | perl -ne "s/^(\\w+).*\$/\$1/; chomp; \$ENV{use}{\$_}++; END{ print map {\"\$ENV{use}{\$_}\\t\$_\\n\"} keys %{\$ENV{use}} };" | sort -rn'
alias killmine="perl -E 'map {system \"kill -9 \$_\"} grep {\$_ ne \$\$} map {s/^\\s*(\\d+).*\\n/\$1/;\$_} grep {/\$ARGV[0]/} \`ps\`;'"
alias top1='top -bn1 | head -n 7 | tail -1; top -bn1 '
alias top7='top -bn1 | head -n 7; top -bn1 '

alias psmem='ps auxf | sort -n -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

alias cpuinfo='lscpu'
alias gpumeminfo='grep -i --color memory --text /var/log/Xorg.0.log'

alias ports='netstat -tulanp'
alias ping='ping -c 3'

alias ipt='sudo /sbin/iptables'

# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'

## Grep pipe short cuts

if [ -f "~/.bash_eternal_history" ]; then
    alias ghistory='cat ~/.bash_eternal_history | /bin/grep -P --color'
else
    alias ghistory='history | /bin/grep -P --color'
fi
alias gps='ps aux | head -1; ps aux | /bin/grep -v " /bin/grep " - | /bin/grep -P --color'
alias glsof='lsof 2> /dev/null | head -1; lsof 2> /dev/null | /bin/grep -v " /bin/grep " - | /bin/grep -P --color'

## From http://www.ukuug.org/events/linux2003/papers/bash_tips/

alias mkdir='mkdir -p'
alias grep='/bin/grep -P --color'
alias fgrep='/bin/fgrep --color'
alias hl='/bin/grep -C 9999 --color=ALWAYS -P'
alias scp='scp -pr'
alias dirs='dirs -v'
alias jobs='jobs -l'
alias df='df-colour'
#alias watch='perl -e "while(1) { print qq{\e[2J\e[0;0H\e[K@ARGV\n\n}; system qq{@ARGV}; sleep 2 }"'
alias watch='watch -c'
#perl -e 'while(1) {print "\e[2J\e[0;0H\e[K@ARGV\n\n"; system "@ARGV"; sleep 2 }' ps auxf '| grep -P --color=yes mmssend'

## Tar simplifications
alias tgz='tar -czf'
alias tbz2='tar -cjf'
alias utgz='tar -xzf'
alias utbz2='tar -xjf'
alias mktar='tar -cf'
alias untar='tar -xf'

# super user commands
please() { sudo `history -p '!!'`; }

# Tidying
alias jsontidy='json_pp -f json -t json -json_opt relaxed,pretty,allow_singlequote'
alias yamltidy='json_xs -f yaml -t yaml'

# Touch pad toggling
alias padoff='xinput -disable 14'
alias padon='xinput -enable 14'
alias touchpad-off='xinput list | grep TouchPad | perl -nlE '\''/id=(\d+)/; system qq{xinput set-prop $1 "Device Enabled" 0}'\'

# chromium aliases
alias chromium-gs3='chromium-browser --disable-web-security --user-agent="Mozilla/5.0 (Linux; U; Android 4.0.4; en-au; GT-I9300 Build/IMM76D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30" 2> /dev/null > /dev/null'
alias chromium-ip3='chromium-browser --disable-web-security --user-agent="Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_0 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7A341 Safari/528.16" 2> /dev/null > /dev/null'
alias chromium-ipad='chromium-browser --disable-web-security --user-agent="Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10" 2> /dev/null > /dev/null'
alias chromium-ipad2='chromium-browser --disable-web-security --user-agent="Mozilla/5.0 (iPad; CPU OS 5_1 like Mac OS X; en-us) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B176 Safari/7534.48.3" 2> /dev/null > /dev/null'

# cpanm-install
alias cpanm-install='wget -O- http://cpanmin.us | sudo perl - App::cpanminus'

# wget
alias wget='wget -c'

# realclear
alias realclear='perl -le "print q{ } for 0..999"'

# node
alias local-npm='local-npm --directory ~/.local-npm'
alias nrun='time npm run'

## Un-characterised

alias sd='perl -MClass::Date -le "print Class::Date->new(\$_) for (@ARGV)" 2>/dev/null'

alias prove='time prove -j4 --state=slow,save -l '

alias module-starter='module-starter --mb --author="Ivan Wills" --email="ivan.wills@gmail.com"'

alias ctags='ctags --exclude=blib --exclude=_build --exclude=Build --exclude=tmp'

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -out -selection clipboard'

alias dietlog='chown www-data:www-data -R /tmp/diet*'

alias home='perl -MClass::Date=now -le "system qq{cd \$ENV{HOME}/src; tar cjf home-} . now()->strftime(q{%Y-%m-%d}) . {q.tar.bz2 home}"'

alias gitlogcount='git log | grep Author | perl -nle "(\$a) = /<([^>]+)>/; \$ENV{BLAH}{\$a}++; END { print join qq/\n/, map { sprintf qq/%37s => %d/, \$_, \$ENV{BLAH}{\$_} } sort { \$ENV{BLAH}{\$a} <=> \$ENV{BLAH}{\$b} } keys %{\$ENV{BLAH}} }"'

alias hlist="hlist -e 'Build|_build|blib|META.yml|tags|.sw[pnox]\$'"

alias perle='perl -MData::Dumper -MPath::Tiny -MJSON::XS=decode_json,encode_json -MYAML::XS=Dump,Load,DumpFile,LoadFile'


alias aem='cd "/home/ivan/aem/AEM6.1" &&  java -Dhttp.proxyHost=localhost -Dhttp.proxyPort=4502 -Denv=dev -debug -Djava.awt.headless=true -XX:MaxPermSize=512M -XX:-UseSplitVerifier -Xnoagent -Xmx2048M -Xmx2048M -Djava.compiler=NONE -Dsling.run.modes=local,author,crx2  -Xdebug -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30305 -jar aem6-author-p4502.jar -nofork -gui &'
