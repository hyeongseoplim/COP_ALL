const {sql, poolPromise} = require('../db.js');

exports.ka3794 = async (req, res) => {
  const pool = await poolPromise;
  const result = await pool.request()
    .execute('dbo.PIMS_STATISTICS_4084_STATREPORT');
    
  return res.json(result.recordsets);
};
