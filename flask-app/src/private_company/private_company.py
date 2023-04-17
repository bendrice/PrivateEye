from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


private_companies = Blueprint('private_companies', __name__)

# Adds company information
@private_companies.route('/company', methods=['POST'])
def add_company():
    the_data = request.json
    current_app.logger.info(the_data)
    name = the_data['company_name']
    state = the_data['company_state']
    industry_size = the_data['industry_size']
    industry = the_data['industry']
    query1 = 'insert into Industry (size , industry_name) values (' + str(industry_size) + ', "' + industry + '")'
    query2 = 'insert into Company (industry_id, company_name, company_state, company_status) values(LAST_INSERT_ID(), "'
    query2 += name + '", "'+ state + '", 1)'
    current_app.logger.info(query1)
    current_app.logger.info(query2)
    cursor = db.get_db().cursor()
    cursor.execute(query1)
    cursor.execute(query2)
    db.get_db().commit()
    return 'Success'
 


# Adds company details
@private_companies.route('/company_details', methods=['POST'])
def add_company_details():
    the_data = request.json
    current_app.logger.info(the_data)
    co_name = the_data['co_name']
    margins = the_data['margins']
    revenue = the_data['revenue']
    ceo = the_data['ceo']
    cto = the_data['cto']
    cio = the_data['cio']
    query = 'INSERT INTO Company_Details (company_id, margins, revenue, ceo, cto, cio) '
    query += 'VALUES ((SELECT company_id FROM Company WHERE company_name = "' + co_name + '"), '
    query += str(margins) + ', '
    query += str(revenue) + ', '
    query += '"' + ceo + '", '
    query += '"' + cto + '", '
    query += '"' + cio + '")'
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'



# Gets PE firms
@private_companies.route('/pefirm', methods=['GET'])
def get_pe_firms():
    cursor = db.get_db().cursor()
    cursor.execute('select pe_name, pe_state, aum from PE_Firm')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Makes ask
@private_companies.route('/ask', methods=['POST'])
def make_ask():
    the_data = request.json
    current_app.logger.info(the_data)
    company_name = the_data['company_name']
    ask_range = the_data['ask_range']
    initial_ask_price = the_data['initial_ask_price']
    query1 = 'insert into Ask (ask_range, ask_price, ask_status) values("'
    query1 += str(ask_range) + '", "'
    query1 += str(initial_ask_price) + '", 1)'
    current_app.logger.info(query1)
    cursor = db.get_db().cursor()
    cursor.execute(query1)
    query2 = 'update Company set ask_id = LAST_INSERT_ID()  where company_name = "' + company_name +'"'
    current_app.logger.info(query2)
    cursor = db.get_db().cursor()
    cursor.execute(query2)

    db.get_db().commit()
    return 'Success'

# Updates ask
@private_companies.route('/update_ask', methods=['PUT'])
def update_ask():
    the_data = request.json
    current_app.logger.info(the_data)
    co_name = the_data['co_name']
    updated_ask_price = the_data['updated_ask_price']
    query = 'UPDATE Ask SET ask_price = '
    query += str(updated_ask_price) + ' WHERE ask_id = (SELECT ask_id FROM Company WHERE company_name = "'  + co_name + '")'
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'

# Deletes ask
@private_companies.route('/delete_ask', methods=['DELETE'])
def delete_ask():
    the_data = request.json
    current_app.logger.info(the_data)
    companys_name = the_data['companys_name']
    query = 'DELETE FROM Ask WHERE ask_id = (SELECT ask_id FROM Company WHERE company_name = "'  + companys_name + '")'
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'

# Browse bids
@private_companies.route('/get_bids', methods=['GET'])
def get_bids():
    cursor = db.get_db().cursor()
    cursor.execute('select PF.pe_id, pe_name, pe_state,aum, bid_price from Bid join PE_Firm PF on Bid.pe_id = PF.pe_id')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Accept/Reject Bid
@private_companies.route('/update_bid_status', methods=['PUT'])
def update_bid_status():
    the_data = request.json
    current_app.logger.info(the_data)
    pe_id = the_data['pe_id']
    status = the_data['status']
    query = 'UPDATE Bid SET bid_status = '
    query += str(status) + ' WHERE pe_id = '  + str(pe_id)
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'