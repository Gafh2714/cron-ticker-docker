const { syncDB } = require('../../tasks/sync-db');

describe('pruebas en sync-db', () => { 

    test('debe ejecutar el proceso dos veces', () => { 

        syncDB();
        const times = syncDB();
        expect( times ).toBe(2);
    })

 })