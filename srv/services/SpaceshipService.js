const capacities = {
    Transporter: 100,
    Corvette: 200,
    Frigate: 500,
    Cruiser: 1000,
    Battlecruiser: 2000,
    Battleship: 5000,
    Aurora: 10000
};

async function SpaceshipsReadService(req, next) {
    const data = await next();
    const rows = Array.isArray(data) ? data : [data];

    for (const row of rows) {
        row.capacity = capacities[row.shipClass] || 0;
    }
    return data;
}

module.exports = { READ: SpaceshipsReadService };