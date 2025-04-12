SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: brews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.brews (
    id text NOT NULL,
    name text,
    state text,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: device_telemetries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.device_telemetries (
    id text NOT NULL,
    device_id text NOT NULL,
    row_key text NOT NULL,
    type text NOT NULL,
    version text NOT NULL,
    mac_address text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: COLUMN device_telemetries.row_key; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.device_telemetries.row_key IS 'Unique key for the telemetry data from ratp.io';


--
-- Name: COLUMN device_telemetries.type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.device_telemetries.type IS 'Used for STI, this will be Brezilla, Hydrometer, etc';


--
-- Name: COLUMN device_telemetries.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.device_telemetries.version IS 'Version of the device';


--
-- Name: COLUMN device_telemetries.mac_address; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.device_telemetries.mac_address IS 'MAC address of the device';


--
-- Name: COLUMN device_telemetries.metadata; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.device_telemetries.metadata IS 'Holds specific information from the devices';


--
-- Name: devices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.devices (
    id text NOT NULL,
    name text NOT NULL,
    ratp_id uuid NOT NULL,
    type text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: COLUMN devices.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.devices.name IS 'Device Name shown in the UI';


--
-- Name: COLUMN devices.ratp_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.devices.ratp_id IS 'Primary key from the ratp.io API';


--
-- Name: COLUMN devices.type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.devices.type IS 'Used for STI, this will be Brezilla, Hydrometer, etc';


--
-- Name: COLUMN devices.metadata; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.devices.metadata IS 'Holds specific information from the devices';


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id text NOT NULL,
    user_id text NOT NULL,
    ip_address text,
    user_agent text,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id text NOT NULL,
    email_address text NOT NULL,
    password_digest text NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: brews brews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brews
    ADD CONSTRAINT brews_pkey PRIMARY KEY (id);


--
-- Name: device_telemetries device_telemetries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_telemetries
    ADD CONSTRAINT device_telemetries_pkey PRIMARY KEY (id);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_device_telemetries_on_device_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_device_telemetries_on_device_id ON public.device_telemetries USING btree (device_id);


--
-- Name: index_devices_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_devices_on_name ON public.devices USING btree (name);


--
-- Name: INDEX index_devices_on_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON INDEX public.index_devices_on_name IS 'We don''t want to have devices with the same name';


--
-- Name: index_devices_on_ratp_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_devices_on_ratp_id ON public.devices USING btree (ratp_id);


--
-- Name: INDEX index_devices_on_ratp_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON INDEX public.index_devices_on_ratp_id IS 'This is a PK on the ratp.io API';


--
-- Name: index_devices_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_devices_on_type ON public.devices USING btree (type);


--
-- Name: index_sessions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_user_id ON public.sessions USING btree (user_id);


--
-- Name: index_users_on_email_address; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email_address ON public.users USING btree (email_address);


--
-- Name: device_telemetries fk_rails_3e8ec8312d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_telemetries
    ADD CONSTRAINT fk_rails_3e8ec8312d FOREIGN KEY (device_id) REFERENCES public.devices(id);


--
-- Name: sessions fk_rails_758836b4f0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_758836b4f0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20250410192756'),
('20250410191802'),
('20250410165044'),
('20250409202533'),
('20250409202532');

