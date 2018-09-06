source ~/.gdbinit-gef.py 

# When inspecting large portions of code the scrollbar works better than 'less'
#set pagination off

# Keep a history of all the commands typed. Search is possible using ctrl-r
set history save on
set history filename ~/.gdb_history
set history size 32768
set history expansion on


# Custom functions

define preload
    if $argc != 1
        set environment LD_PRELOAD=
    else
        set environment LD_PRELOAD=$arg0
    end
end
document preload
Set LD_PRELOAD environment variable
preload <library path>
end

define re
    if $argc == 0
        target remote localhost:4444
    else
        target remote localhost:$arg0
    end
end
document re
Remote debug
re <port>
end

define tret
    stepuntil ret
end
document tret
Step until ret instruction
end

define tcall
    stepuntil tcall
end
document tcall
Step until call instruction
end

