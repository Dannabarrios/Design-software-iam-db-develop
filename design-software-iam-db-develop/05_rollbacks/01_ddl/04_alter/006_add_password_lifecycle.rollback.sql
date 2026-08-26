DROP INDEX IF EXISTS session.ix_password_reset_request_ip_requested_at;
DROP INDEX IF EXISTS session.ix_password_reset_request_user_requested_at;

ALTER TABLE identity."user"
    DROP COLUMN IF EXISTS password_changed_at,
    DROP COLUMN IF EXISTS temporary_password_expires_at,
    DROP COLUMN IF EXISTS must_change_password;

