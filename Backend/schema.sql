CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    website TEXT,
    location VARCHAR(150),
    industry VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL,

    title VARCHAR(150) NOT NULL,
    job_type VARCHAR(50),
    location VARCHAR(150),
    description TEXT,
    salary VARCHAR(100),
    job_url TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_job_company
        FOREIGN KEY (company_id)
        REFERENCES companies(id)
        ON DELETE CASCADE
);


CREATE TABLE applications (
    id SERIAL PRIMARY KEY,

    user_id INTEGER NOT NULL,
    job_id INTEGER NOT NULL,

    status VARCHAR(30) NOT NULL DEFAULT 'SAVED',

    applied_date DATE,
    notes TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_application_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_application_job
        FOREIGN KEY (job_id)
        REFERENCES jobs(id)
        ON DELETE CASCADE,

    CONSTRAINT check_application_status
        CHECK (
            status IN (
                'SAVED',
                'APPLIED',
                'ASSESSMENT',
                'INTERVIEW',
                'OFFER',
                'REJECTED',
                'WITHDRAWN'
            )
        ),

    CONSTRAINT unique_user_job
        UNIQUE (user_id, job_id)
);