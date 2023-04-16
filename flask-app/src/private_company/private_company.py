from flask import Blueprint, request, jsonify, make_response
import json
from src import db


private_companies = Blueprint('private_companies', __name__)
