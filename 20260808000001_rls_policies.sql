-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE verification_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE issuer_requests ENABLE ROW LEVEL SECURITY;

-- 1. Users RLS Policies
CREATE POLICY "Admin full access users" ON users
    FOR ALL USING (auth.jwt() ->> 'role' = 'Admin');

CREATE POLICY "Users read own record" ON users
    FOR SELECT USING (auth.uid() = id);

-- 2. Organizations RLS Policies
CREATE POLICY "Admin full access organizations" ON organizations
    FOR ALL USING (auth.jwt() ->> 'role' = 'Admin');

CREATE POLICY "Issuers read own organization" ON organizations
    FOR SELECT USING (id = (SELECT organization_id FROM users WHERE id = auth.uid()));

-- 3. Documents RLS Policies
CREATE POLICY "Admin full access documents" ON documents
    FOR ALL USING (auth.jwt() ->> 'role' = 'Admin');

CREATE POLICY "Issuers read org documents" ON documents
    FOR SELECT USING (
        organization_id = (SELECT organization_id FROM users WHERE id = auth.uid())
        AND auth.jwt() ->> 'role' = 'Issuer'
    );

CREATE POLICY "Issuers insert org documents" ON documents
    FOR INSERT WITH CHECK (
        issuer_id = auth.uid()
        AND auth.jwt() ->> 'role' = 'Issuer'
    );

CREATE POLICY "Owners read own documents" ON documents
    FOR SELECT USING (owner_id = auth.uid());

-- 4. Verification Logs RLS Policies
CREATE POLICY "Admin full access verification_logs" ON verification_logs
    FOR ALL USING (auth.jwt() ->> 'role' = 'Admin');

CREATE POLICY "Public insert verification logs" ON verification_logs
    FOR INSERT WITH CHECK (true);

-- 5. Audit Logs RLS Policies
CREATE POLICY "Admin full access audit_logs" ON audit_logs
    FOR ALL USING (auth.jwt() ->> 'role' = 'Admin');

CREATE POLICY "System insert audit logs" ON audit_logs
    FOR INSERT WITH CHECK (true);

-- 6. Issuer Requests RLS Policies
CREATE POLICY "Admin full access issuer_requests" ON issuer_requests
    FOR ALL USING (auth.jwt() ->> 'role' = 'Admin');

CREATE POLICY "Users read own request" ON issuer_requests
    FOR SELECT USING (requested_by = auth.uid());

CREATE POLICY "Authenticated users create request" ON issuer_requests
    FOR INSERT WITH CHECK (requested_by = auth.uid());
