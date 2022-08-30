if status is-interactive
    # Commands to run in interactive sessions can go here
end

if ! command -v hostname > /dev/null 2>&1
    if command -v hostnamectl > /dev/null 2>&1
        alias hostname="hostnamectl hostname"
    else
        alias hostname="uname -o"
    end
end

function fish_greeting
    if command -v lolcat > /dev/null 2>&1
        figlet "Name" | lolcat
        echo -e "Welcome Back!\n" | lolcat
    else
        figlet "Name"
        echo -e "Welcome Back!\n"
    end
end

