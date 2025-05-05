@app.route('/api/otp-login', methods=['POST'])
def otp_login():
    phone = request.json['phone']
    otp = random.randint(100000, 999999)

    # ذخیره OTP در Redis
    r.setex(f'otp_{phone}', 300, otp)

    # ارسال OTP به کاربر (در اینجا فرض می‌کنیم که از Twilio یا یک API مشابه استفاده می‌کنید)
    # send_sms(phone, otp)

    return jsonify({'message': 'OTP به شماره شما ارسال شد!'}), 200
