_ = require 'lodash'
Promise = require 'bluebird'
joi = require 'joi'
mongoose = require '../mongoose'
validate = require '../../utils/validate'
ValidationError = require '../errors/validationError'

###*
  @class core.models.HardWare
###

HardWare = mongoose.model 'HardWare', require('./hardWare.schema')

validateSchema =
  config: joi.string().max(4000)
  status: joi.string().max(4000)
  ls: joi.string().max(4000)
  channels: joi.string().max(4000)
  playlist: joi.string().max(4000)

###*
  `HardWare`的验证`Schema`

  @static
  @property {Joi} validateSchema
###
module.exports.validateSchema = validateSchema

###*
  创建新硬件

  @static
  @method create
  @throws {ValidationError}
  @param {Object} hardWareToCreate
  @return {Promise} `resolve`时返回新创建的`HardWare`对象
###
module.exports.create = (hardWareToCreate) ->
  hardWareToCreate = validate.sanitize hardWareToCreate, validateSchema
  HardWare
    .create hardWareToCreate
    .then (hardWare) -> hardWare.toObject()
    .catch (err) ->
      throw err

###*
  更新硬件信息

  @static
  @method update
  @param {ObjectId} id
  @param {Object} patch
  @return {Promise} `resolve`时返回更新后的`HardWare`对象
  @throws {ValidationError}
###
module.exports.update = (id, patch) ->
  patch = validate.sanitize patch, validateSchema
  HardWare
    .findOne _id: id
    .then (hardWare) ->
      if not hardWare
        throw new ValidationError '硬件不存在'
      else
        _.merge hardWare, patch
        hardWare.save()
    .then (hardWare) ->
      hardWare.toObject()

###*
  根据`id`获取`Hardware`

  @static
  @method get
  @param {ObjectId} id
  @return {Promise} `resolve`时返回`Hardware`对象, 没有找到时返回`undefined`
  @throws {ValidationError}
###
module.exports.get = (id) ->
  id = validate.sanitize id, joi.objectId()
  HardWare
    .findOne _id: id
    .then (hardWare) -> hardWare?.toObject()