_ = require 'lodash'
mongoose = require '../mongoose'

definition =
  hardWare:
    type: mongoose.Schema.Types.ObjectId
    ref: 'HardWare'
    required: true
    index: true

  script:
    type: String
    required: true
    maxlength: 4000

  result:
    type: String
    maxlength: 4000

opts =
  id: false
  versionKey: false
  toObject:
    transform: (doc, obj) -> _.omit obj, '_id'
  toJSON:
    transform: (doc, obj) -> _.omit obj, '_id'

schema = new mongoose.Schema(definition, opts)

module.exports = schema
