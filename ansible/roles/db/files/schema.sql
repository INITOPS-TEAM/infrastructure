-- PictApp database schema
-- Metadata-only schema (no binary data stored in DB)

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    last_ip TEXT -- added
);

CREATE TABLE IF NOT EXISTS images (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    -- original_filename TEXT NOT NULL,
    stored_filename TEXT NOT NULL UNIQUE,
    -- stored_path TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    description VARCHAR, -- added
    location VARCHAR, -- added

    CONSTRAINT fk_images_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

-- Indexes for common access patterns
CREATE INDEX IF NOT EXISTS idx_images_user_id
    ON images(user_id);

CREATE INDEX IF NOT EXISTS idx_images_created_at
    ON images(created_at);

CREATE TABLE IF NOT EXISTS likes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    image_id INTEGER NOT NULL,

    CONSTRAINT fk_likes_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_likes_image
        FOREIGN KEY (image_id)
        REFERENCES images(id)
        ON DELETE CASCADE,

    CONSTRAINT unique_user_image
        UNIQUE (user_id, image_id)
);

-- Indexes for common access patterns
CREATE INDEX IF NOT EXISTS idx_likes_user_id ON likes(user_id);
CREATE INDEX IF NOT EXISTS idx_likes_image_id ON likes(image_id);

-- Add last_ip in users table
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_ip TEXT;

CREATE TABLE IF NOT EXISTS banned (
    id SERIAL PRIMARY KEY,
    ip TEXT UNIQUE
);

ALTER TABLE images ADD COLUMN IF NOT EXISTS description VARCHAR; -- added
ALTER TABLE images ADD COLUMN IF NOT EXISTS location VARCHAR; -- added
ALTER TABLE images DROP COLUMN IF EXISTS original_filename;
ALTER TABLE images DROP COLUMN IF EXISTS stored_path;