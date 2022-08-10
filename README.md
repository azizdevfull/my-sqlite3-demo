
# my-sqlite3-demo

# How to install

```
git clone https://github.com/azizdevfull/my-sqlite3-demo.git
```

```
cd my-sqlite3-demo
```

# How to use

```
ruby ruby my_sqlite_cli.rb
```

# See all players

```
my_sqlite_cli>> SELECT * FROM nba_player_data.csv
```

# Find by players data

```
my_sqlite_cli>> SELECT year_start, position FROM nba_player_data.csv WHERE year_start = 1991
```

# Update player data 

```
my_sqlite_cli>> UPDATE nba_player_data.csv SET height='20',weight='500'WHERE name ='Milos Babic'
```
