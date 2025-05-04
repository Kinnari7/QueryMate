import { Database } from "sqlite3";
import fs from "fs";

const sqlStr = fs.readFileSync("data/querymate.sql").toString().split(";");

const db = new Database("database", (err) => {
	if (err) {
		return console.error(err.message);
	}

	console.log("Connected to the in-memory SQlite database.");
});

db.serialize(() => {

	db.run(`INSERT INTO customers (...) VALUES (...)`, (err) => {
		if (err) console.error("Insert error:", err.message);
	});

	sqlStr.forEach((query) => {

		if (query) {
			db.run(query, (err) => {
				if (err) {
					return console.error(err.message);
				}
			});
		}

	});

	db.run("COMMIT");

});

db.close((err) => {
	if (err) {
		return console.error(err.message);
	}

	console.log("Closed the database connection.");
});