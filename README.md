To use the report template, copy (or symlink)
[`report`](https://github.com/adityasz/typst-templates/tree/master/report)
into `${DATA_DIR}/typst/packages/templates/report/0.1.0`, where
[`${DATA_DIR}`](https://docs.rs/dirs/latest/dirs/fn.data_dir.html) is
`${XDG_DATA_HOME:-$HOME/.local/share}` on Linux and
`${HOME}/Library/Application Support` on macOS.

Then, import stuff using `#import "@templates/report:0.1.0": *`.

```console
aditya@fedora:~/.local/share/typst$ tree -l      
.
├── greeted
└── packages
    └── templates
        └── report
            └── 0.1.0 -> /home/aditya/Templates/typst/report
                ├── lib.typ
                ├── math.typ
                └── typst.toml
```

See [this](https://typst.app/blog/2023/package-manager) blog post to learn about
Typst's (very simple) package manager.
