# Pronunciation Fetcher Script

This script fetches and plays pronunciations for given letters using Google Translate's Text-to-Speech (TTS) service. It caches the pronunciations locally to avoid redundant fetches.

## Prerequisites

Ensure the following commands are installed on your system:
- `mpg123`
- `jq`
- `grep`
- `md5sum`

## How It Works

1. **Check Dependencies**: The script first checks if the required commands are installed.
2. **Create Cache Directory**: A cache directory (`./cache`) is created to store the fetched pronunciations.
3. **Fetch Pronunciation**: 
    - If a pronunciation is already cached, it plays the cached file.
    - If not, it fetches the pronunciation from Google Translate and saves it to the cache.
4. **Get Random Phrase**:
    - For a given letter, it picks a random phrase from a file (`phrases.txt`). 
    - If no phrases are found, it defaults to the letter itself.
5. **Generate Cache File Name**: The cache file name is generated using the MD5 hash of the phrase.

## Usage

1. **Run the Script**: Execute the script in a bash shell.
2. **Input a Letter**: The script waits for a single letter input (A-Z or 0-9).
3. **Play Pronunciation**: The script fetches and plays the pronunciation for the given letter.

### Commands and Functions

- **Dependency Check**: Ensures that `mpg123`, `jq`, `grep`, and `md5sum` are installed.
- **Cache Directory Creation**: `mkdir -p "$CACHE_DIR"` creates the cache directory if it doesn't exist.
- **fetch_pronunciation**: Fetches and plays the pronunciation for the given text.
- **get_random_phrase**: Gets a random phrase for the given letter from `phrases.txt`.
- **generate_cache_file_name**: Generates a cache file name based on the MD5 hash of the phrase.
- **Main Loop**: Waits for user input, processes the input letter, fetches the corresponding pronunciation, and plays it.

### Changing the Language

To change the language of the pronunciation, modify the language code in the URL inside the `fetch_pronunciation` function. The language code (`tl`) can be set to any supported language, such as `en` for English or `de` for German.

```bash
local url="https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=$encoded_text&tl=de"
```

## Example

To run the script, simply use:

```bash
./pronunciation_fetcher.sh
```

Then, press any letter key to hear its pronunciation. Press 'Ctrl+C' to exit the script.

---

## English Phrases (phrases_en.txt)

```plaintext
A A as in Apple
B B as in Boy
C C as in Cat
D D as in Dog
E E as in Elephant
F F as in Fish
G G as in Giraffe
H H as in House
I I as in Ice
J J as in Juice
K K as in Kite
L L as in Lion
M M as in Monkey
N N as in Nose
O O as in Orange
P P as in Pencil
Q Q as in Queen
R R as in Rabbit
S S as in Sun
T T as in Tiger
U U as in Umbrella
V V as in Violin
W W as in Water
X X as in Xylophone
Y Y as in Yellow
Z Z as in Zebra
```


## Polish 

```plaintext
A A jak Ania
B B jak Babcia
C C jak Ciocia
C C jak Cebula
D D jak Dom
E E jak Ewa
F F jak Franek
G G jak Grażyna
H H jak Halina
I I jak Irena
J J jak Jan
J J jak JACEK
K K jak Kupa
L L jak Lalka
M M jak Marcel
N N jak Noga
O O jak Oko
P P jak Pociąg
P P jak Piotr
R R jak Reka
S S jak Siusiu
S S jak Samolot
T T jak Tata
T T jak Traktor
U U jak Urszula
W W jak Weronika
W W jak Woda
W W jak Wiadro
Y Y jak Yunees
Z Z jak Zwierze
Z Z jak Zab
I I jak Igla
O O jak Olga
M M jak Marcel
B B jak Babcia
C C jak Ciocia
C C jak Cebula
T T jak Tata
T T jak Traktor
K K jak Kupa
W W jak Weronika
W W jak Woda
W W jak Wiadro
H H jak Halina
S S jak Siusiu
S S jak Samolot
P P jak Pociąg
B B jak Budowniczy
P P jak Piotr
```


## German Phrases (phrases_de.txt)

```plaintext
A A wie Apfel
B B wie Ball
C C wie Clown
D D wie Dom
E E wie Elefant
F F wie Fisch
G G wie Giraffe
H H wie Haus
I I wie Igel
J J wie Junge
K K wie Katze
L L wie Löwe
M M wie Maus
N N wie Nase
O O wie Orange
P P wie Pferd
Q Q wie Quelle
R R wie Rose
S S wie Sonne
T T wie Tiger
U U wie Uhr
V V wie Vogel
W W wie Wasser
X X wie Xylophon
Y Y wie Yacht
Z Z wie Zebra
```

---

Save the above content as `README.md` in your repository for easy reference and documentation. Save the provided phrases in their respective files `phrases_en.txt` and `phrases_de.txt`. Modify the script as necessary to point to the correct phrases file based on the desired language.
