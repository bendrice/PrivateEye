from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


technicians = Blueprint('technicians', __name__)

#create technician profile 
@technicians.route('/technician', methods=['POST'])
def add_company():
    the_data = request.json
    current_app.logger.info(the_data)
    technician_id = the_data['technician_id']
    last_name = the_data['last_name']
    first_name = the_data['first_name']
    query = 'insert into Technician values("'
    query += str(technician_id) + '", "'
    query += last_name + '", "'
    query += first_name + '")'
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'


# Updates company status to closed (unavailible) given company name
# when that company has accepetd a bid from PE_Firm 
@technicians.route('/company_status', methods=['PUT'])
def update_company_status():
    the_data = request.json
    company_name = the_data['company_name']
    current_app.logger.info(the_data)
    query = 'update Company set company_status = 0 where company_name = "' + company_name + '"'
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'

# Gets companies that exist  
@technicians.route('/company/<company_id>', methods=['GET'])
def get_companies(company_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Company where company_id = {0}'.format(company_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Updates Deal feasability score between 1 to 10
@technicians.route('/deal_feasibility', methods=['PUT'])
def update_deal_feasibility():
    the_data = request.json
    deal_id = the_data['deal_id']
    score = the_data['score']
    current_app.logger.info(the_data)
    query = 'UPDATE Deal SET feasibility = '+str(score) + ' WHERE deal_id = ' + str(deal_id) 
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'


#LANDING PAGE ROUTES edittable by technician 


#Update top 5 Deals
@technicians.route('/top_5', methods=['PUT'])
def update_top_5():
    the_data = request.json
    deal_id = the_data['deal_id']
    current_app.logger.info(the_data)
    query = 'UPDATE Deal SET top_5 = 1  WHERE deal_id = ' + str(deal_id) 
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'


# Populates the Top 5 deals landing page
@technicians.route('/top_5_page', methods=['GET'])
def top_5_page():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT pe_name, ask_price, bid_price, feasibility, '
               +'company_name from PE_Firm join Bid B on PE_Firm.pe_id = B.pe_id '+
               'join Deal D on B.deal_id = D.deal_id join Ask A on D.ask_id = A.ask_id '+
               'join Company C on A.ask_id = C.ask_id limit 5')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
 