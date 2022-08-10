
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
ruby my_sqlite_cli.rb
```

# See all players

```
my_sqlite_cli>> SELECT * FROM nba_player_data.csv
```

# Find by players data

```
my_sqlite_cli>> SELECT year_start, position FROM nba_player_data.csv WHERE year_start = 1991
```

# Add player data 

```
my_sqlite_cli>> INSERT INTO nba_player_data.csv VALUES ('Azizbek Isroilov','2004','2100','F', '5-9', '200','September 11, 2004','28 School')
```

# Update player data 

```
my_sqlite_cli>> UPDATE nba_player_data.csv SET height='20',weight='500'WHERE name ='Azizbek Isroilov'
```


# Destroy player data 

```
my_sqlite_cli>> DELETE FROM nba_player_data.csv WHERE name = 'Azizbek Isroilov'
```
