const {sql, poolPromise} = require('../db.js');

exports.ka3794 = async (req, res) => {
  const pool = await poolPromise;

  const result = await pool.request()
    .input('UnivServiceId', sql.Int, req.query.UnivServiceId)
    .input('StartDate', sql.DateTime, req.query.StartDate)
    .input('EndDate', sql.DateTime, req.query.EndDate)
    .execute('dbo.COP_ProcLogic_1');
    
  return res.json(result.recordsets);
};
