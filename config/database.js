const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('blogdb', 'root', '', {
    host: 'localhost',
    dialect: 'mysql'
});

module.exports = sequelize;
