const idColumn = 'id';
const nameColumn = 'name';
const descriptionColumn = 'description';
const locationColumn = 'location';
const priorityColumn = 'priority';
const timeColumn = 'time';
const dateColumn = 'date';

const dbName = 'crud.db';
const eventsTable = 'events';

const createEventsTable = '''CREATE TABLE IF NOT EXISTS "$eventsTable" (
      "$idColumn" INTEGER PRIMARY KEY,
      "$nameColumn" TEXT NOT NULL,
      "$descriptionColumn" TEXT NOT NULL,
      "$locationColumn" TEXT,
      "$priorityColumn" TEXT NOT NULL,
      "$timeColumn" TEXT,
      "$dateColumn" TEXT NOT NULL
    );''';
