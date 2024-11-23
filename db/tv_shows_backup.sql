PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE Shows (
    id INTEGER PRIMARY KEY,
    url TEXT,
    name TEXT,
    genres TEXT,
    status TEXT,
    runtime INTEGER,
    averageRuntime INTEGER,
    premiered TEXT,
    ended TEXT,
    officialSite TEXT,
    language TEXT,
    type TEXT,
    webChannel_id INTEGER NOT NULL,
    FOREIGN KEY (webChannel_id) REFERENCES WebChannels(id) ON DELETE CASCADE
);
CREATE TABLE Episodes (
    id INTEGER PRIMARY KEY,
    show_id INTEGER,
    url TEXT,
    name TEXT,
    season INTEGER,
    number INTEGER,
    type TEXT,
    airdate TEXT,
    airtime TEXT,
    airstamp TEXT,
    runtime INTEGER,
    FOREIGN KEY (show_id) REFERENCES Shows(id) ON DELETE CASCADE
);
CREATE TABLE Networks (
    id INTEGER PRIMARY KEY,
    name TEXT
);
CREATE TABLE WebChannels (
    id INTEGER PRIMARY KEY,
    network_id INTEGER NOT NULL,
    name TEXT,
    officialSite TEXT,
    FOREIGN KEY (network_id) REFERENCES Networks(id) ON DELETE CASCADE
);
DELETE FROM sqlite_sequence;
CREATE INDEX idx_show_name ON Shows(name);
CREATE INDEX idx_episode_show_id ON Episodes(show_id);
CREATE INDEX idx_webchannel_name ON WebChannels(name);
COMMIT;
