[![Build Status](https://travis-ci.org/masukomi/crystal_fmt.svg?branch=master)](https://travis-ci.org/masukomi/crystal_fmt)

# Crystal Format (crystal_fmt)

Takes a grid of strings and produces a text table with 
custom borders, dividers, and header separator.

For example:

```crystal
[["things", "stuff"], ["a", "b"], ["c", nil]]
```

would be converted to...

```text
| things | stuff  |
| ------ | ----- |
| a      | b     |
| c      |       |
```

Inspired by the [fmt egg](http://wiki.call-cc.org/eggref/4/fmt) for Chicken
Scheme.


## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  crystal_fmt:
    github: masukomi/crystal_fmt
```

## Usage

API Documentations is available [here](https://masukomi.github.io/crystal_fmt/).

```crystal
require "crystal_fmt"

# SIMPLE USAGE
table_data = Array(Array(String | Nil)).new
[["column 1", "column 2"], ["a", "b"], ["c", "d"]].each do |row|
  table_data << row
end

t = Table.new(table_data)
t.format
# ^^^ produces
# | column 1 | column 2 |
# | -------- | -------- |
# | a        | b        |
# | c        | d        |

# CUSTOM DIVIDERS AND BORDERS
options = Hash(Symbol,String|Bool).new
options[:left_border] = "> "
options[:right_border] = " <"
options[:divider] = " . "
options[:header_divider] = "^"
t.format(options)
# Produces
# > column 1 . column 2 <
# > ^^^^^^^^ . ^^^^^^^^ <
# > a        . b        <
# > c        . d        <

```

## Development

Before developing any feature please create an issue where you describe your idea.

Before working on a bug, please make sure there isn't already a GitHub Issue for it. If there is, make sure no-one's already working on it. If there isn't please create one. 

If you have a useful sounding idea I'll probably want to merge it. If you've
already coded up improvements for yourself, go ahead and file an Issue
describing it and then make a PR. 

Note: while I really want to add your contributions, no PR will be merged
without passing unit tests.

Please ping me at @masukomi on Twitter so that I see your Issue promptly.


## Contributing

1. Fork it ( https://github.com/masukomi/crystal_fmt/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
    * Please include [unit tests]((https://crystal-lang.org/api/Spec.html)) 
      and [documentation](https://crystal-lang.org/docs/conventions/documenting_code.html).
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
6. Poke [@masukomi](https://twitter.com/masukomi) on Twitter to make sure it gets seen promptly.

## Contributors

- [masukomi](https://github.com/masukomi) masukomi - creator, maintainer
