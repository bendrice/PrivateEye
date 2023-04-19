# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 



# PrivateEye

Our project is a Deal Sourcing Platform that has 3 user personas:
1. Private Company: Founders seeking investment for their firm externally.
2. Financial buyer: Private Equity Company analysts and associates looking to invest in private companies.
3. Investment Banker: Deal platform middle men that streamline the buy and sell side.

Unlike public companies whose financial statements are available for everyone to see and invest in on a stock exchange, a plethora of private companies seek investors to grow. However, they are unable to do so efficiently unless they have existing relationships with institutional investors-like hedge funds and private equity companies. Private Equity companies on the other side struggle finding companies to add to their portfolio, especially within specific industries. The due diligence process to source a deal that matches their requirements is cumbersome and time consuming.

The problem our platform aims to solve is to automate the current deal sourcing process.
Essentially, PrivateEye aims to automate the process of private companies looking for investments and financial buyers looking to invest by letting companies and buyers securely browse each other's financials, weigh profitability matrixes, present bids and asks, and acquire (or be acquired) seamlessly!

What we learned from this project is the technical aspects of how to create a database that connects and functions with our back end as well as our front end.(make this longer and more specific bc I dont know what to write for this - it is the what did we learn) 

We also learned the broader process of a private equity company going about acquiring companies to add to their investment portfolio with the aim of increasing their value and generating returns for investors. The process involves sourcing potential targets, conducting due diligence, valuing the company, securing financing, acquiring the target company, improving its operations and increasing its value, and ultimately exiting the investment by selling the company. Private equity firms use a combination of debt and equity financing to acquire companies and work to implement growth strategies post-acquisition to increase their value. The ultimate goal is to sell the company at a higher valuation than the purchase price to generate returns for investors.

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
Our flask API contains routes for three different personas - Private Equity Firm,  Private Company, and Technician. Here, routes contain both get and post requests in the form of our features.

**Private Company Features**
- add a company to the platform 
- upload company company specifics like size, revenue, costs, and profits
- search tool to look for potential buyers
- upload ask price for investments 
- accept/reject bid from buyer ("Update status on bid")

**Platform Technician Features**
- update company status as closed once it has accepted a bid from a PE Firm 
- Approve company legitimacy 
- Approve Deal Feasibiltiy
- Update Top 5 Deal landing page

**Private Equity Firm Features**
- Bidding: The ability to bid on the companies that are listed on database bid
- Search: Search for features that are desired
- Compare: Compare different company features of which are the best to aquire
- add/update: Add and update portfolio database


## Docker Compose
Docker compose is used to build the applicaiton form the boilterplate_copy. It has our containers and waits for them to be started up which holds our data and applicaiton functionality. 

## AppSmith
Appsmith functions as our front end taking in the data from the users or personas which grabs our information from our VS Code and Datagrip to display in the front end. 