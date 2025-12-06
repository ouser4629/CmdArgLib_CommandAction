
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
C> ls -lF | grep '*'
-rwxr-xr-x   1 po  staff    446648 Nov 17 12:53 ca1-simple*
-rwxr-xr-x   1 po  staff    425568 Nov 17 12:53 ca2-stateful*
-rwxr-xr-x   1 po  staff    510640 Nov 17 12:53 ca3-text-math*
-rwxr-xr-x   1 po  staff  15579304 Nov 17 12:53 CmdArgLibMacrosModule-tool*
mf8-sed*
```

```
> ./ca3-text-math tree

ca3-text-math
├── .text
│   ├── .phrases - Print sorted phrases.
│   └── .quotes
│       ├── .general - Print quotes about life in general.
│       └── .computing - Print quotes about computing.
├── .math
│   ├── .add - Add a list of doubles.
│   └── .mult - Multiply a list of doubles.
├── .general - Print quotes about life in general.
└── tree - Print the tree hierarchy.
```

</details>

<details>
<summary>Tip</summary>

If you want to experiment it is recomended that you use the follow cycle.

* Edit sources at ~/Temp/CmdArgLib_CommandAction/Sources
* Go to the "build" terminal tab at ~/Temp/CmdArgLib_CommandAction
* Rebuild: `> swift build -c release`
* Go to the "release" terminal tab at ~/Temp/CmdArgLib_CommandAction/.build/release
* Run the programs `> ./ca...`

Occasionally you might want to run `rm -rf .build .swiftpm` in the build tab. If
you do, be sure to close the current release tab, and set up a new one after the
build completes.

</details>
