

# PrivateEye

PrivateEye is a Deal Sourcing Platform that aims to automates the process of private companies looking for investments and financial buyers looking to invest by letting companies and Private Equity firms securely browse each other's financials, weigh profitability matrixes, present bids and asks, and acquire (or be acquired)!

Unlike public companies whose financial statements are available for everyone to see and invest in on a stock exchange, a plethora of private companies seek investors to grow. However, they are unable to do so efficiently unless they have existing relationships with institutional investors-like hedge funds and private equity companies. Private Equity companies on the other side struggle finding companies to add to their portfolio, especially within specific industries. The due diligence process to source a deal that matches their requirements is cumbersome and time consuming.

The problem our platform aims to solve is to automate the current deal sourcing process.

The platform has 3 user personas:
1. Private Company: Founders seeking investment for their firm externally.
2. Financial buyer: Private Equity Firm analysts and associates looking to invest in private companies and add to their portfolio.
3. PrivateEye technician: Deal platform middle men that streamline the buy and sell process.


## Database
Each table includes primary key(s) and foreign key(s). Here are the following tables and attributes:

- **Technician**: Technician_ID, Technician_First, Technician Last
- **Deal**: Deal_Id, Deal_active, Feasibility, StartDate, ApprovalDate
- **Bid**: Bid_ID, Bid_price, Bid_status, Bid_Range
- **Private Equity Firm**: PE_ID, AUM, PE_state, PE_Name
- **Portfolio**: Portfolio_ID, Portfolio_companies, Fund
- **Ask**: Ask_ID, Ask_Range, Ask_Status, Ask_Price
- **Industry**: Industry_ID, Industry_Name, Size
- **Company**: Company_ID, Company_Status, Company_State, Company_Name
- **Company Details**: CD_ID, Margins, Revenue, CEO, CIO, CTO


## Features
Our flask API contains routes for three different personas - Private Equity Firm,  Private Company, and Technician. Here, routes contain 'GET', 'POST', and 'DELETE' requests in the form of our features.

**Private Company Features**
- Add a company to the platform 
- Upload company company specifics like size, revenue, costs, and margins
- Search tool to look for potential buyers
- Upload ask price for investments 
- Accept/reject bid from buyer ("Update status on bid")

**Platform Technician Features**
- Update company status as closed once it has accepted a bid from a PE Firm 
- Approve company legitimacy 
- Approve Deal Feasibiltiy
- Update Top 5 Deal landing page

**Private Equity Firm Features**
- Bidding: The ability to bid on the companies that are listed on database bid
- Search: Search for features that are desired
- Compare: Compare different company features of which are the best to aquire
- Add/Update: Add and update portfolio database


## Docker Compose
To start the application: 
Build the images with `docker compose build`. 
Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## AppSmith
Appsmith functions as our front end taking in the data from the users or personas which grabs our information from our VS Code and Datagrip to display in the front end. 

## Link to Walkthrough 
https://www.youtube.com/watch?v=4kHaZN8YpzM 