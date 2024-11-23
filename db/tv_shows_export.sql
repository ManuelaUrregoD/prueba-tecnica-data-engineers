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
    schedule_time TEXT,
    schedule_days TEXT,
    rating_average REAL,
    weight INTEGER,
    webChannel_id INTEGER NOT NULL,
    externals_thetvdb INTEGER,
    externals_imdb TEXT,
    summary TEXT,
    updated INTEGER,
    language TEXT,
    type TEXT,
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
    summary TEXT,
    image_medium TEXT,
    image_original TEXT,
    FOREIGN KEY (show_id) REFERENCES Shows(id) ON DELETE CASCADE
);
CREATE TABLE Links (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    episode_id INTEGER,
    show_id INTEGER,
    self_href TEXT,
    show_href TEXT,
    previous_episode_href TEXT,
    previous_episode_name TEXT,
    next_episode_href TEXT,
    next_episode_name TEXT,
    FOREIGN KEY (episode_id) REFERENCES Episodes(id) ON DELETE CASCADE,
    FOREIGN KEY (show_id) REFERENCES Shows(id) ON DELETE CASCADE
);
CREATE TABLE Networks (
    id INTEGER PRIMARY KEY,
    name TEXT,
    country_name TEXT,
    country_code TEXT,
    country_timezone TEXT
);
CREATE TABLE WebChannels (
    id INTEGER PRIMARY KEY,
    network_id INTEGER NOT NULL,
    name TEXT,
    country_name TEXT,
    country_code TEXT,
    country_timezone TEXT,
    officialSite TEXT,
    FOREIGN KEY (network_id) REFERENCES Networks(id) ON DELETE CASCADE
);
CREATE TABLE ShowNetwork (
    show_id INTEGER,
    network_id INTEGER,
    webChannel_id INTEGER,
    PRIMARY KEY (show_id, network_id, webChannel_id),
    FOREIGN KEY (show_id) REFERENCES Shows(id) ON DELETE CASCADE,
    FOREIGN KEY (network_id) REFERENCES Networks(id) ON DELETE CASCADE,
    FOREIGN KEY (webChannel_id) REFERENCES WebChannels(id) ON DELETE CASCADE
);
DELETE FROM sqlite_sequence;
CREATE INDEX idx_show_name ON Shows(name);
CREATE INDEX idx_episode_airdate ON Episodes(airdate);
CREATE INDEX idx_network_name ON Networks(name);
CREATE INDEX idx_webchannel_name ON WebChannels(name);
COMMIT;
