+++
title = "Hello"
date = 2026-02-04

[taxonomies]
tags = ["random","non-technical"]

+++

After spending the last week designing and making this site, I think I am quite pleased with how it looks now

I know this might not be the most feature-rich blog but it's simple enough to not cause me a headache every time I want to make a new post

## Setup

This blog is built on [Zola](https://github.com/getzola/zola) with my custom [theme](https://github.com/HexDump0/hexdump-web). Using both zola and my theme is quite simple just clone my repo and mess around with as config.
Theme specific customization is under the `extra` table

From `config.toml`
```toml
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

Everything else is either self-explanatory or in zola's [docs](https://www.getzola.org/documentation/) just don't be a skid and steal my shit with no effort of your own.

---


## Credits

*Banner image: Photo by [Marek Piwnicki](https://unsplash.com/photos/snowy-mountain-peak-under-streaking-stars-pE9RxXqGbd4) on Unsplash*
