from flask import Flask, request, jsonify
import hashlib
import redis
import jwt
import os

app = Flask(__name__)

# تنظیمات Redis
r = redis.Redis(host='localhost', port=6379, db=0)

# تنظیمات JWT
app.config['SECRET_KEY'] = 'your_secret_key'

# ثبت‌نام کاربر
@app.route('/api/signup', methods=['POST'])
def signup():
    data = request.get_json()

    
    password_hash = hashlib.sha256(data['password'].encode()).hexdigest()

    db.session.add(user)
    db.session.commit()

    return jsonify({'message': 'کاربر با موفقیت ثبت شد!'}), 201

if __name__ == '__main__':
    app.run(debug=True)
