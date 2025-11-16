
## CmdArgLib\_CommandAction

This package contains three examples using the `CommandAction` macro provided
by the [Command Argument Libary](https://github.com/ouser4629/cmd-arg-lib.git).

* Cmd_1_Simple - a simple command tree with only two levels
* Cmd_2_Stateful - the same as Cmd\_1\_Simple using a stateful command tree
* Cmd_3_TextAndMath - multi-level stateful command tree

---

## Setup

<details>
<summary>Clone and Build</summary>

```
> mkdir Temp
> cd Temp
> git clone https://github.com/ouser4629/CmdArgLib_CommandAction.git
cd CmdArgLib_CommandAction
> swift build -c release
```

You might warning get a warning: 'input verification failed'.

</details>

<details>
<summary>Run</summary>

Press command T to set up a new tab in the terminal.

In the new tab:

```
> cd .build/release/
```

```
> ls -1F | grep '*'
CmdArgLibMacrosModule-tool*
mf1-basic*
mf2-man*
mf3-enums*
mf4-lists*
mf5-positionals*
mf6-show-macros*
mf7-errors*
mf8-sed*
```

```
> ./mf1-basic --version
  version 0.1.0 - 2025-10-14
```

</details>

<details>
<summary>Tip</summary>

If you want to experiment it is recomended that you use the follow cycle.

* Edit sources at ~/Temp/CmdArgLib_CommandAction/Sources
* Go to the "build" terminal tab at ~/Temp/CmdArgLib_CommandAction
* Rebuild: `> swift build -c release`
* Go to the "release" terminal tab at ~/Temp/CmdArgLib_CommandAction/.build/release
* Run the programs `> ./mf...`

Occasionally you might want to run `rm -rf .build .swiftpm` in the build tab. If
you do, be sure to close the current release tab, and set up a new one after the
build completes.

</details>
