from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


technicians = Blueprint('technicians', __name__)

#create technician profile 
@technicians.route('/technician', methods=['POST'])
def add_company():
    the_data = request.json
    current_app.logger.info(the_data)
    last_name = the_data['last_name']
    first_name = the_data['first_name']
    query1 = 'insert into Technician (technician_last, technician_first) values("'
    query1 += last_name + '", "'
    query1 += first_name + '")'
    current_app.logger.info(query1)
    cursor = db.get_db().cursor()
    cursor.execute(query1)
    db.get_db().commit()
    return 'Technician created!'

# Get technician id
@technicians.route('/technician', methods=['GET'])
def get_tech_id():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Technician')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = jsonify(json_data)
    the_response.status_code = 200
    return the_response

# Make company visible to PE firms 
@technicians.route('/company', methods=['POST'])
def update_company_visibility():
    the_data = request.json
    tech_id = the_data['tech_id']
    company_id1 = the_data['company_id1']
    current_app.logger.info(the_data)
    query = 'insert into Allows values (1, ' + str(company_id1) + ', ' + str(tech_id) + ')'
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'The Company is visible to PE firms!'

# Updates company status to closed (unavailible) given company name
# when that company has accepted a bid from PE_Firm as well as deal status 
@technicians.route('/company', methods=['PUT'])
def update_company_deal_status():
    the_data = request.json
    company_name = the_data['company_name']
    deal_id = the_data['deal_id']
    current_app.logger.info(the_data)
    query1 = 'update Company set company_status = 0 where company_name = "' + company_name + '"'
    current_app.logger.info(query1)
    cursor = db.get_db().cursor()
    cursor.execute(query1)

    query2 = 'UPDATE Deal SET deal_status = 0 where deal_id = ' + str(deal_id)
    current_app.logger.info(query2)
    cursor = db.get_db().cursor()
    cursor.execute(query2)

    db.get_db().commit()
    return 'The Company ' + company_name + ' is no longer discoverable by PE Firms!'

# Gets company for particular id
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

 # Delete company if not legit
@technicians.route('/company', methods=['DELETE'])
def delete_ask():
    the_data = request.json
    current_app.logger.info(the_data)
    company_id = the_data['company_id']
    query = 'DELETE FROM Company WHERE company_id = '  + str(company_id)
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Company id: ' + str(company_id) +'deleted!'


# Updates Deal feasability score between 1 to 10
@technicians.route('/deal', methods=['PUT'])
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
    return 'Deal score updated to ' + str(score) + ' for id:' + str(deal_id)


#LANDING PAGE ROUTES edittable by technician 

# Updates inputted deal as a Top 5 deal to be visible on landing page 
# (only possible if the deal has been feasible with a score greater than 5)
@technicians.route('/top_5', methods=['PUT'])
def update_top_5():
    the_data = request.json
    d_id = the_data['d_id']
    current_app.logger.info(the_data)
    query = 'UPDATE Deal SET top_5 = 1  WHERE feasibility > 7 AND deal_id = ' + str(d_id) 
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'


# Populates the Top 5 deals landing page
@technicians.route('/top_5', methods=['GET'])
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
