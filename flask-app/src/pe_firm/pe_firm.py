from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

# Private Equity Firm blueprint 
pe_firms = Blueprint('pe_firms', __name__)

# Create Private Equity firm profile
@pe_firms.route('/pe_firm', methods=['POST'])
def create_pe_firm():
    the_data = request.json
    current_app.logger.info(the_data)
    created_pe_name = the_data['created_pe_name']
    private_equity_state = the_data['private_equity_state']
    aum = the_data['aum']

    query = "INSERT INTO PE_Firm (pe_name, pe_state, aum) VALUES ('{}', '{}', {})".format(created_pe_name, private_equity_state, aum)

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'PE Firm: ' + created_pe_name +  ' created!'

# Gets all the private companies and their information like state, revenue, industry, etc.
@pe_firms.route('/company', methods=['GET'])
def get_company():
    cursor = db.get_db().cursor()
    cursor.execute('Select company_name, company_state, industry_name, revenue, margins  from Company join Company_Details CD on Company.company_id = CD.company_id'
    + ' join Allows A on Company.company_id = A.company_id join Industry I on Company.industry_id = I.industry_id'
    + ' where company_status = 1 and is_visible = 1')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Search for potential private companies that a Private Equity firm would want to potentially invest in 
# Gets all the private companies and their information 
@pe_firms.route('/company_information', methods=['GET'])
def get_potential_companies():
    
    the_data = request.json
    current_app.logger.info(the_data)

    ask_maximum = the_data['ask_maximum']
    industry = the_data['industry']
    state_location = the_data['state_location']
    c_status = the_data['c_status']
    c_margins_minimum = the_data['c_margins_minimum']
    c_revenue_minimum = the_data['c_revenue_minimum']

    query = "SELECT * FROM Company join Company_Details CD on Company.company_id = CD.company_id join Ask A on Company.ask_id = A.ask_id join Industry I on I.industry_id = Company.industry_id join Allows A2 on Company.company_id = A2.company_id where ask_price <= " 
    query+= str(ask_maximum) + " and industry_name = '" 
    query+= industry + "' and company_state = '" 
    query+= state_location + "' and company_status = " 
    query+= str(c_status) + " and margins >= " 
    query+= str(c_margins_minimum) + " and revenue >= " 
    query+= str(c_revenue_minimum) + " and is_visible = 1"  

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Compare five companies and return a comparison table based on revenue and margin
@pe_firms.route('/compare', methods=['GET'])
def compare_companies():
    the_data = request.json
    current_app.logger.info(the_data)
    company_name_1 = the_data['company_name_1']
    company_name_2 = the_data['company_name_2']
    company_name_3 = the_data['company_name_3']
    company_name_4 = the_data['company_name_4']
    company_name_5 = the_data['company_name_5']

    query = f"SELECT company_name, margins, revenue FROM Company JOIN Company_Details CD ON Company.company_id = CD.company_id WHERE company_name in ('{company_name_1}', '{company_name_2}', '{company_name_3}', '{company_name_4}', '{company_name_5}')"

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response



# Get existing deals
@pe_firms.route('/deal', methods=['GET'])
def get_deals():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT pe_name, ask_price, bid_price, feasibility, company_name from PE_Firm join Bid B on PE_Firm.pe_id = B.pe_id join Deal D on B.deal_id = D.deal_id join Ask A on D.ask_id = A.ask_id join Company C on A.ask_id = C.ask_id join Allows A2 on C.company_id = A2.company_id where company_status = 1 and is_visible = 1')
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

# Creates a bid for a specific private company  
@pe_firms.route('/bid', methods=['POST'])
def create_bid():
    the_data = request.json
    current_app.logger.info(the_data)
    pe_name_1 = the_data['pe_name_1']
    d_id = the_data['d_id']
    b_range = the_data['b_range']
    b_price = the_data['b_price']
    query = 'INSERT INTO Bid (pe_id, deal_id, bid_range, bid_price, bid_status) '
    query += 'VALUES ((SELECT pe_id FROM PE_Firm WHERE pe_name = "' + pe_name_1 + '"), '
    query += '(SELECT deal_id FROM Deal WHERE deal_id = "' + str(d_id) + '"), '
    query += str(b_range) + ', '
    query += str(b_price) + ', '
    query += '0)'
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Bid created and sent!' 

# Updates a bid for a specific private company
@pe_firms.route('/bid', methods=['PUT'])
def update_bid():
    the_data = request.json
    current_app.logger.info(the_data)
    specific_bid_id = the_data['specific_bid_id']
    bid_range = the_data['bid_range']
    bid_price = the_data['bid_price']

    query1 = 'UPDATE Bid SET bid_range = '
    query1 += str(bid_range) + ' WHERE bid_id = ' + str(specific_bid_id)

    query2 = 'UPDATE Bid SET bid_price = '
    query2 += str(bid_price) + ' WHERE bid_id = ' + str(specific_bid_id)

    current_app.logger.info(query1)
    cursor1 = db.get_db().cursor()
    cursor1.execute(query1)

    current_app.logger.info(query2)
    cursor2 = db.get_db().cursor()
    cursor2.execute(query2)
    db.get_db().commit()

    return 'Success'


#Delete a bid
@pe_firms.route('/bid', methods=['DELETE'])
def delete_bid():
    the_data = request.json
    current_app.logger.info(the_data)

    bid_id_key = the_data['bid_id_key']

    query = "DELETE from Bid where bid_id = " + str(bid_id_key)

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'



#Create a portfolio company 
@pe_firms.route('/portfolio', methods=['POST'])
def create_portfolio():
    the_data = request.json
    current_app.logger.info(the_data)

    the_pe_firm = the_data['the_pe_firm']
    fund_size = the_data['fund_size']

    query = "INSERT INTO Portfolio (pe_id, fund) VALUES ((SELECT pe_id FROM PE_Firm WHERE pe_name = '" 
    query+= the_pe_firm + "'), " + str(fund_size) + ")"

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'



#Add a private company to a specific PE firm's portfolio
@pe_firms.route('/portfolio', methods=['PUT'])
def add_portfolio_company():
    the_data = request.json
    current_app.logger.info(the_data)

    the_private_company = the_data['the_private_company']
    private_equity_firm = the_data['private_equity_firm']

    query = "UPDATE Company SET portfolio_id = (SELECT portfolio_id FROM PE_Firm JOIN Portfolio P ON PE_Firm.pe_id = P.pe_id WHERE pe_name = '{0}') WHERE company_name = '{1}'".format(private_equity_firm, the_private_company)

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success'




