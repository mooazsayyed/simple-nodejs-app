const chai = require('chai');
const { expect } = chai;
const app = require('../index'); // Adjust the path if needed

// Dynamically import chai-http
(async () => {
    const chaiHttp = await import('chai-http');
    chai.use(chaiHttp);

    describe('Node.js Application Tests', () => {
        it('should load the homepage', (done) => {
            chai.request(app)
                .get('/')
                .end((err, res) => {
                    expect(res).to.have.status(200);
                    expect(res.text).to.include('Search for a person');
                    done();
                });
        });
    });
})();
