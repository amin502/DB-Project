import redis
import random
import time

# اتصال به Redis
r = redis.Redis(host='localhost', port=6379, db=0)

# تولید کد OTP
otp = random.randint(100000, 999999)

# ذخیره OTP در Redis با زمان انقضا 5 دقیقه (300 ثانیه)
r.setex('otp_user_123', 300, otp)

# دریافت OTP از Redis
stored_otp = r.get('otp_user_123')
print(f'OTP ذخیره شده: {stored_otp.decode("utf-8")}')
