#!/usr/bin/env python
# coding: utf-8

import string
import re
from nltk.corpus import stopwords
from nltk import word_tokenize
import nltk
nltk.download('punkt')
from nltk.stem.snowball import SnowballStemmer
from wordcloud import WordCloud
import matplotlib.pyplot as plt

text = str()
with open("/Users/mak/Desktop/TAL/ProgrammationEtProjetEncadré/M1TAL_immigration/dumps-text/ru_total2.txt", "r") as f:
    text = f.read()

text = text.lower()
spec_chars = string.punctuation + '\n\xa0«»\t—…'
text = re.sub('\n', '', text)
text = "".join([ch for ch in text if ch not in spec_chars])
text_tokens = word_tokenize(text)
text = nltk.Text(text_tokens)

russian_stopwords = stopwords.words("russian")
russian_stopwords.extend(['это', 'нею', 'button', 'twitter', 'telegram', 'livejournal', 'года', 'который', 'изза'])

text_tokens = [token.strip() for token in text_tokens if token not in russian_stopwords]
text = nltk.Text(text_tokens)


get_ipython().run_line_magic('matplotlib', 'inline')

text_raw = " ".join(text)

wordcloud = WordCloud().generate(text_raw)
#lower max_font_size, change the maximum number of word and lighten the background:
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.show()



