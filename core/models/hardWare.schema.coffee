_ = require 'lodash'
mongoose = require '../mongoose'

definition =
  config:
    type: String
    required: true
    maxlength: 4000

  status:
    type: String
    maxlength: 4000

  ls:
    type: String
    maxlength: 4000

  channels:
    type: String
    maxlength: 4000

  playlist:
    type: String
    maxlength: 4000

opts =
  versionKey: false
  timestamps: true
  toObject:
    getters: true
    transform: (doc, obj) -> _.omit obj, '_id'
  toJSON:
    getters: true
    transform: (doc, obj) -> _.omit obj, '_id'

schema = new mongoose.Schema(definition, opts)

schema.virtual 'type'
  .get -> 'HardWare'

schema.pre 'findOne', (next) ->
  @select ''
  next()

module.exports = schema
