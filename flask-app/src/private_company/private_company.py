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
    query = 'insert into Company (company_name, company_state) values("'
    query += name + '", "'
    query += state + '")'
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
