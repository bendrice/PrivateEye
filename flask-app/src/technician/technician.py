from flask import Blueprint, request, jsonify, make_response
import json
from src import db


technicians = Blueprint('technicians', __name__)

