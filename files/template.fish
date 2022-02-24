if status is-interactive
    # Commands to run in interactive sessions can go here
end
function fish_greeting
    figlet Name | lolcat
    echo -e "Welcome Back!\n" | lolcat
end

