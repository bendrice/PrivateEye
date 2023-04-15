from flask import Blueprint, request, jsonify, make_response
import json
from src import db


p_companies = Blueprint('p_companies', __name__)
