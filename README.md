## Notes

In order to reload inside same Neovim session:
```
:lua package.loaded["avocado"] = nil
:lua require("avocado")
```
