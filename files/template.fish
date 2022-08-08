if status is-interactive
    # Commands to run in interactive sessions can go here
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

