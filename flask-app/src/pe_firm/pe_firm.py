from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

pe_firms = Blueprint('pe_firms', __name__)

# Gets all the private companies and their information 
@pe_firms.route('/private_companies', methods=['GET'])
def get_private_companies():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Company')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# # Creates a bid for a specific private company  FIX AFTER MAKING THE ASK EXAMPLES
# @pe_firms.route('/create_bid', methods=['POST'])
# def create_bid():
#     the_data = request.json
#     current_app.logger.info(the_data)
#     name = the_data['name']
#     d_id = the_data['d_id']
#     b_range = the_data['b_range']
#     b_price = the_data['b_price']
#     query = 'insert into Bid (pe_id, deal_id, bid_range, bid_price, bid_status) '
#     query += 'VALUES ((SELECT pe_id FROM PE_Firm WHERE pe_name = "' + name + '"), '
#     query += 'VALUES ((SELECT deal_id FROM Deal WHERE deal_id = "' + d_id + '"), '
#     query += str(b_range) + '", "'
#     query += str(b_price) + '", "'
#     query += '", 0)'
#     current_app.logger.info(query)
#     cursor = db.get_db().cursor()
#     cursor.execute(query)
#     db.get_db().commit()
#     return 'Success'

#function that lets you see all of the deals that exist
@pe_firms.route('/get_deals', methods=['GET'])
def get_deals():

    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Deal')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# # Updates a bid for a specific private company - NOT DONEEEEEEEEEEEEEEEEEEEEEEEEEEEE
# @pe_firms.route('/', methods=['PUT'])
# def get_private_companies():
#     # get a cursor object from the database
#     cursor = db.get_db().cursor()

#     # use cursor to query the database for a list of products
#     cursor.execute('SELECT * FROM Company')

#     # grab the column headers from the returned data
#     column_headers = [x[0] for x in cursor.description]

#     # create an empty dictionary object to use in 
#     # putting column headers together with data
#     json_data = []

#     # fetch all the data from the cursor
#     theData = cursor.fetchall()

#     # for each of the rows, zip the data elements together with
#     # the column headers. 
#     for row in theData:
#         json_data.append(dict(zip(column_headers, row)))

#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

#search for potential companies that a Private Equity firm would want to potentially invest in 
# Gets all the private companies and their information 
@pe_firms.route('/get_potential_companies', methods=['GET'])
def get_potential_companies():
    
    the_data = request.json
    current_app.logger.info(the_data)

    ask_maximum = the_data['ask_maximum']
    industry = the_data['industry']
    state_location = the_data['state_location']
    c_status = the_data['c_status']
    c_margins = the_data['c_margins']
    c_revenue = the_data['revenue']

    query = "SELECT * FROM Company join Company_Details CD on Company.company_id = CD.company_id join Ask A on Company.ask_id = A.ask_id join Industry I on I.industry_id = Company.industry_id where ask_price <= " + str(ask_maximum) + " and industry_name = '" + industry + "' and company_state = '" + state_location + "' and company_status = " + str(c_status) + " and margins >= " + str(c_margins) + " and revenue >= " + str(c_revenue)
    
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


