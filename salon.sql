--
-- PostgreSQL database dump
--

DROP DATABASE IF EXISTS salon;

CREATE DATABASE salon;

\c salon

--
-- Name: appointments; Type: TABLE; Schema: public
--

CREATE TABLE appointments (
    appointment_id integer NOT NULL,
    customer_id integer,
    service_id integer,
    time character varying
);


--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE; Schema: public
--

CREATE SEQUENCE appointments_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public
--

ALTER SEQUENCE appointments_appointment_id_seq OWNED BY appointments.appointment_id;


--
-- Name: customers; Type: TABLE; Schema: public
--

CREATE TABLE customers (
    customer_id integer NOT NULL,
    phone character varying,
    name character varying
);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public
--

CREATE SEQUENCE customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public
--

ALTER SEQUENCE customers_customer_id_seq OWNED BY customers.customer_id;


--
-- Name: services; Type: TABLE; Schema: public
--

CREATE TABLE services (
    service_id integer NOT NULL,
    name character varying
);


--
-- Name: services_service_id_seq; Type: SEQUENCE; Schema: public
--

CREATE SEQUENCE services_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public
--

ALTER SEQUENCE services_service_id_seq OWNED BY services.service_id;


--
-- Name: appointments appointment_id; Type: DEFAULT; Schema: public
--

ALTER TABLE ONLY appointments ALTER COLUMN appointment_id SET DEFAULT nextval('appointments_appointment_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public
--

ALTER TABLE ONLY customers ALTER COLUMN customer_id SET DEFAULT nextval('customers_customer_id_seq'::regclass);


--
-- Name: services service_id; Type: DEFAULT; Schema: public
--

ALTER TABLE ONLY services ALTER COLUMN service_id SET DEFAULT nextval('services_service_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public
--



--
-- Data for Name: customers; Type: TABLE DATA; Schema: public
--



--
-- Data for Name: services; Type: TABLE DATA; Schema: public
--

INSERT INTO services VALUES (1, 'cut');
INSERT INTO services VALUES (2, 'color');
INSERT INTO services VALUES (3, 'style');


--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE SET; Schema: public
--

SELECT pg_catalog.setval('appointments_appointment_id_seq', 1, false);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public
--

SELECT pg_catalog.setval('customers_customer_id_seq', 1, false);


--
-- Name: services_service_id_seq; Type: SEQUENCE SET; Schema: public
--

SELECT pg_catalog.setval('services_service_id_seq', 3, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public
--

ALTER TABLE ONLY appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: customers customers_phone_key; Type: CONSTRAINT; Schema: public
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_phone_key UNIQUE (phone);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_id);


--
-- Name: appointments appointments_customer_id_fkey; Type: FK CONSTRAINT; Schema: public
--

ALTER TABLE ONLY appointments
    ADD CONSTRAINT appointments_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES customers(customer_id);


--
-- Name: appointments appointments_service_id_fkey; Type: FK CONSTRAINT; Schema: public
--

ALTER TABLE ONLY appointments
    ADD CONSTRAINT appointments_service_id_fkey FOREIGN KEY (service_id) REFERENCES services(service_id);

--
-- PostgreSQL database dump complete
--
