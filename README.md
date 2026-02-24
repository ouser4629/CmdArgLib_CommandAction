## CmdArgLib_Completion

This repositiory provides three executable programs built
using [cmd-arg-lib](https://github.com/ouser4629/cmd-arg-lib.git). The
repository has a dual purpose.

* Provide examples of how to use the `CommandAction` macro.
* Provide examples of how to generate fish and zsh completion scripts.

The programs `cf-ca1-simple` and `cf-ca2-stateful` use the `CommandAction` macro.
These, along with `cf-print`, generate fish and zsh completion scripts.

---

## 


### Top Level

```
> cf-ca3-assisted -h
DESCRIPTION
  Demonstrate CLI command completion with a stateful hierarchical command.

USAGE
  cf-ca3-assisted [-ht] [state <state-options>] <other-subcommand>

META-OPTIONS
  --generate-fish-completion-script   Print a fish completion script.
  --generate-zsh-completion-script    Print a zsh completion script.
  -t                                  Show a hierarchical list of commands.
  -h/--help                           Show this help screen.

SUBCOMMANDS
  state     Provide state for subsequent commands.
  quotes    Print quotes by famous people.
  food      Print food items passed in from the command line.
  files     Print file names passed in from the command line.
```

```
> cf-ca3-assisted -ht
cf-ca3-assisted [state]
├── quotes
│   ├── general - Print quotes about life in general.
│   └── computing - Print quotes about computing.
├── food - Print food items passed in from the command line.
└── files - Print file names passed in from the command line.
```


### State level

```
> cf-ca3-assisted state -h
DESCRIPTION
  Provide state for subcommands.

USAGE
  cf-ca3-assisted state [-ulth] [-f <phrase_format>] <subcommand>

OPTIONS
  -f/--format <phrase_format>  A text format ("red", "yellow" or "underlined") to use when
                               displaying quotes.
  -u/--upper                   Show the uppercase version of the quotes.
  -t                           Show a hierarchical list of commands.
  -l/--lower                   Show the lowercase version of the quotes.
  -h/--help                    Show this help screen.

SUBCOMMANDS
  quotes    Print quotes by famous people.
  food      Print food items passed in from the command line.
  files     Print file names passed in from the command line.
``` 
  
```
> cf-ca3-assisted state -ht
cf-ca3-assisted state
├── quotes
│   ├── general - Print quotes about life in general.
│   └── computing - Print quotes about computing.
├── food - Print food items passed in from the command line.
└── files - Print file names passed in from the command line.
```

### Running the program

```
> cf-ca3-assisted quotes general 1
Quote
  Well done is better than well said. - Benjamin Franklin
```

```
> cf-ca3-assisted state -u quotes general 1
Quote
  WHERE ALL THINK ALIKE, NO ONE THINKS VERY MUCH. - WALTER LIPPMANN
```


## Installation

Download and install [cal-arg-lib-package-manager](https://github.com/ouser4629/cmd-arg-lib-package-manager.git).

Make a directory, say Temp, cd to it, and install the programs

```
> mkdir Temp && cd Temp
> git clone https://github.com/ouser4629/CmdArgLib_Completion.git
> cd CmdArgLib_Completion
CmdArgLib_Completion> swift build -c release
CmdArgLib_Completion> calpm install -s fish -s zsh
cf-ca1-simple
    installed "cf-ca1-simple" in /Users/po/.local/bin
    installed "cf-ca1-simple.fish" in /Users/po/.config/fish/completions
    installed "_cf-ca1-simple" in /Users/po/.config/zsh/completions
cf-ca2-stateful
    installed "cf-ca2-stateful" in /Users/po/.local/bin
    installed "cf-ca2-stateful.fish" in /Users/po/.config/fish/completions
    installed "_cf-ca2-stateful" in /Users/po/.config/zsh/completions
cf-ca3-assisted
    installed "cf-ca3-assisted" in /Users/po/.local/bin
    installed "cf-ca3-assisted.fish" in /Users/po/.config/fish/completions
    installed "_cf-ca3-assisted" in /Users/po/.config/zsh/completions
cf-print
    installed "cf-print" in /Users/po/.local/bin
    installed "cf-print.fish" in /Users/po/.config/fish/completions
    installed "_cf-print" in /Users/po/.config/zsh/completions
cd ../..
rm -rf Temp
```

---

