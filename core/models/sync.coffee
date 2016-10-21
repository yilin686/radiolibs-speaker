_ = require 'lodash'
Promise = require 'bluebird'
joi = require 'joi'
mongoose = require '../mongoose'
validate = require '../../utils/validate'
ValidationError = require '../errors/validationError'

###*
  @class core.models.Sync
###

Sync = mongoose.model 'Sync', require('./sync.schema')

validateSchema =
  hardWare: joi.objectId()
  script: joi.string().max(4000)
  result: joi.string().max(4000)

###*
  `Sync`的验证`Schema`

  @static
  @property {Joi} validateSchema
###
module.exports.validateSchema = validateSchema

###*
  创建'Sync'记录

  @static
  @method create
  @throws {ValidationError}
  @param {Object} syncToCreate
  @return {Promise} `resolve`时返回新创建的`Sync`对象
###
module.exports.create = (syncToCreate) ->
  syncToCreate = validate.sanitize syncToCreate, validateSchema
  Sync
    .create syncToCreate
    .then (sync) -> sync.toObject()
    .catch (err) ->
      throw err

###*
  更新'Sync'信息

  @static
  @method update
  @param {ObjectId} hwId
  @param {Object} patch
  @return {Promise} `resolve`时返回更新后的`Sync`对象
  @throws {ValidationError}
###
module.exports.update = (hwId, patch) ->
  patch = validate.sanitize patch, validateSchema
  Sync
    .findOne hardWare: hwId
    .then (sync) ->
      if not sync
        throw new ValidationError '同步信息不存在'
      else
        _.merge sync, patch
        sync.save()
    .then (sync) ->
      sync.toObject()

###*
  根据`hardWare`获取`Sync`

  @static
  @method getByHardWare
  @param {ObjectId} hardWare
  @param {Object} opts 分页信息
  @return {Promise} `resolve`时返回包含分页信息的`Sync`列表
  @throws {ValidationError}
###
module.exports.getByHardWare = (hardWare, opts) ->
  hardWare = validate.sanitize hardWare, validateSchema.hardWare
  Sync
    .find hardWare: hardWare
    .select '-hardWare'
    .sort '-_id'
    .paginate opts