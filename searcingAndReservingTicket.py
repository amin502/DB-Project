@app.route('/api/search-tickets', methods=['GET'])
def search_tickets():
    origin = request.args.get('origin')
    destination = request.args.get('destination')
    travel_date = request.args.get('travel_date')

    # tickets = Ticket.query.filter_by(origin=origin, destination=destination, travel_date=travel_date).all()

    return jsonify({'tickets': 'نتایج جستجو'})  
