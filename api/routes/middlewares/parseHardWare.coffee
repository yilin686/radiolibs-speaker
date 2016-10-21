HardWare = require '../../../core/models/hardWare'
Errors = require '../../errors'

module.exports = (req, res, next) ->
  HardWare
    .get req.params.id
    .then (hardWare) ->
      if not hardWare
        #不存在时创建一个hw
        throw new Errors.HttpErrors[404] "`hardWare: #{req.params.id}`不存在"
      else
        req.ctx.hardWare = hardWare
        next() or null
    .catch next
