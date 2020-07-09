const {sql, poolPromise} = require('../db.js');

exports.ka3794 = async (req, res) => {
  const pool = await poolPromise;
  const result = await pool.request()
    .execute('dbo.COP_ProcLogic_2');

  const rtnDs = [];
  result.recordsets.forEach(function(dt,i){
    let cols, rows;
    cols = Object.keys(dt[0] || {});
    rows = dt.map((dr) => Object.values(dr));
    rtnDs.push({cols, rows});
  });
  return res.json(rtnDs);
};
