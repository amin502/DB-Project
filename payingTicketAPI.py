@app.route('/api/pay', methods=['POST'])
def pay():
    payment_data = request.get_json()

    # انجام پردازش پرداخت
    # اینجا می‌توانید اطلاعات کارت اعتباری را بررسی کنید و پرداخت را انجام دهید.

    # پس از موفقیت، وضعیت پرداخت را به "Completed" تغییر دهید
    # payment.status = 'Completed'
    # db.session.commit()

    return jsonify({'message': 'پرداخت با موفقیت انجام شد!'})
