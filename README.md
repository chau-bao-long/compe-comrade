# compe-comrade
Comrade intelliJ complete source for nvim-compe

## Prerequisites

- Install [comrade](https://github.com/beeender/Comrade)

## Install

- Using your plugin manager
```
Plug 'chau-bao-long/compe-comrade'
```

- Setup `nvim-compe`
```lua
require'compe'.setup {
  ...
  source = {
    ...
    comrade = {
      kind = "  ",
      menu = " [IJ] ",
      priority = 100,
      filetypes = {"kotlin", "java"},
    },
    ...
  };
}
```
