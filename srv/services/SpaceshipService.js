const capacities = {
    Transporter: 100,
    Corvette: 200,
    Frigate: 500,
    Cruiser: 1000,
    Battlecruiser: 2000,
    Battleship: 5000,
    Aurora: 10000
};

async function SpaceshipsReadService(data, req) {
    const ships = Array.isArray(data) ? data : [data];

    for (const ship of ships) {
        ship.capacity = capacities[ship.shipClass] || 0;
    }
}

module.exports = { READ: SpaceshipsReadService };