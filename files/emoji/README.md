## emoji-powerline

Based on Agnoster, extended with emojis representing home and root directories. Paths in the pwd prompt and git branch are split by "/" and joined as powerline segments for a clean aesthetic. Input is broken onto a new line for more consistent positioning.

Colours and emojis used are easily configurable at the top of `./fish_prompt.fish`

Get the full path in your prompt by running:

```sh
set -U fish_prompt_pwd_dir_length 0
```

#### Preview
![emoji-powerline theme](https://i.imgur.com/62aD4l9.png)

#### Characteristics

- If you're under your home directory, "~" is replaced with "🏠"
- If you're outside your home directory, the root-level "/" is replaced with "🌏"
- pwd_prompt is split by "/", each section is turned into a Powerline segment
- Git branch is split by "/", each section is turned into a Powerline segment
- If the previous command failed (⚠️)
- User @ Hostname (if user is not DEFAULT_USER, which can then be set in your profile)
- Git/HG/SVN status
- Branch () or detached head (➦)
- Current branch / SHA1 in detached head state
- Dirty working directory (✱, color change)
- Clean working directory ✔
- Elevated (root) privileges (⚡)
- Current virtualenv (Python)
  You will probably want to disable the default virtualenv prompt. Add to your [`init.fish`](https://github.com/oh-my-fish/oh-my-fish#dotfiles):
  `set --export VIRTUAL_ENV_DISABLE_PROMPT 1`
- Indicate vi mode.

Forked from https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md#agnoster-1
