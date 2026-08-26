ALTER TABLE identity."user"
    ADD COLUMN must_change_password BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN temporary_password_expires_at TIMESTAMPTZ,
    ADD COLUMN password_changed_at TIMESTAMPTZ;

CREATE INDEX ix_password_reset_request_user_requested_at
    ON session.password_reset_request (user_id, requested_at DESC);

CREATE INDEX ix_password_reset_request_ip_requested_at
    ON session.password_reset_request (ip_address, requested_at DESC)
    WHERE ip_address IS NOT NULL;

