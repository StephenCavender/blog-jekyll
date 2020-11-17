if [ -z "$1" ] ; then
    JEKYLL_ENV=production bundle e jekyll b
else
    bundle e jekyll b
fi