{ print eval($1)}

function eval(str,      cmd,line,ret) {
    cmd = "echo \"" str "\" | bc"
    while ( (cmd | getline line) ) {
        ret = line
    }
    close(cmd)
    return ret

}
