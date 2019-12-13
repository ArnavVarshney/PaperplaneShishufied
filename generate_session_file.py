# This script wont run your bot, it just generates a session.

import os

from dotenv import load_dotenv
from telethon import TelegramClient

load_dotenv("config.env")

API_KEY = os.environ.get("API_KEY", None)
API_HASH = os.environ.get("API_HASH", None)

bot = TelegramClient('userbot', API_KEY, API_HASH)
bot.start()
