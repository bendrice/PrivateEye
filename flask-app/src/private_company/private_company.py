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
    query = 'insert into Company (company_name, company_state, company_status) values("'
    query += name + '", "'
    query += state + '", 0)'
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
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
    ask_range = the_data['ask_range']
    initial_ask_price = the_data['initial_ask_price']
    query = 'insert into Ask (ask_range, ask_price, ask_status) values("'
    query += str(ask_range) + '", "'
    query += str(initial_ask_price) + '", 1)'
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
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


