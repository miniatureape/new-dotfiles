# Use ffmpeg to turn a mp4 into a gif, with some good defaults useful for screencasts
mp4togif () {
    # mp4togif some-movie.mp4 some-gif.gif
    ffmpeg -i $1 -vf "fps=24,scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $2
}

# Find out what someone's been up to. Useful for catching up after a vacation or writing feedback
sup () {
    git log -p --author ${1-`whoami`} --since ${2-1weeks}
}

alias nb="cd ~/projects/notes && vim ~/projects/notes/notes.txt"
