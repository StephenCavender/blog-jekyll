if [ -z "$1" ] ; then
    JEKYLL_ENV=production bundle e jekyll s
else
    bundle e jekyll s
fi