import csv
import random
import os
import sys

NUM_ROWS = 50

COLUMNS = ["Название трека", "Исполнитель", "Продолжительность (сек)", "Жанр"]

def generate_row():
    return {
        "Название трека": random.choice([
            "Bohemian Rhapsody", "Stairway to Heaven", "Imagine", 
            "Smells Like Teen Spirit", "Billie Jean", "Hotel California",
            "Like a Rolling Stone", "Hey Jude", "Sweet Child o' Mine", "ЧЕРЕМША", "Я русский"
        ]),
        "Исполнитель": random.choice([
            "Queen", "Led Zeppelin", "John Lennon", "Nirvana", 
            "Michael Jackson", "Eagles", "Bob Dylan", "The Beatles", "Guns N' Roses", "GAZAN", "ШАМАН"
        ]),
        "Продолжительность (сек)": random.randint(120, 420),  # 2-7 минут
        "Жанр": random.choice(["Rock", "Pop", "Classic Rock", "Grunge", "R&B", "Folk"])
    }
OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)
