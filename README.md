# HexDump

A simple Zola theme for my site.

Quick Start
-----------

Prerequisites:

- Install Zola: https://www.getzola.org

1. Serve the site locally with Zola:
    ```bash
	zola serve --open
    ```

2. Build for production
    ```bash
    zola build
    ```


Customization
-------------

Edit `config.toml` to customize the site. Theme-specific options are under the
`extra` table. See the values in the repository for examples.

```toml
[extra]

[extra.home]
text = "Hello I'm HexDump0, a random guy who likes to write, hack stuff (web for now) and rant about stupid stuff."
subtext = ' -"My crime is that of curiosity."'

[extra.socials]
# The icons use Simple Icons names: https://simpleicons.org/
pgp_key = "#"

links = [
    { name = "Discord", url = "#" , icon = "discord" },
    { name = "Matrix", url = "#" , icon = "matrix" },
    { name = "Mail", url = "#" , icon = "maildotru" },
    'sep',
    { name = "GitHub", url = "#" , icon = "github" },
    { name = "GitLab", url = "#" , icon = "gitlab" }

]

[extra.navbar]
name = ["Hexdump", "0"]
items = [
  { name = "About", path = "/", default = true },
  { name = "Blog", path = "/blog" },
  { name = "Socials", path = "/socials" },
]

[extra.footer]
text = "Trust None"
```

Creating posts
--------------

To add a new blog post create a folder under `content/blog/` (for example `my-post`) and add an `index.md` file containing your post and front matter. If you want a banner for the post, place an image file named `banner.png`, `banner.jpg`, or `banner.webp` inside the same folder

Example layout for a post:

- `content/blog/my-post/index.md`
- `content/blog/my-post/banner.jpg`
