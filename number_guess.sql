--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guessing;
--
-- Name: number_guessing; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guessing WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guessing OWNER TO freecodecamp;

\connect number_guessing

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    score integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 11, 1);
INSERT INTO public.games VALUES (2, 22, 1);
INSERT INTO public.games VALUES (3, 33, 1);
INSERT INTO public.games VALUES (4, 23, 6);
INSERT INTO public.games VALUES (5, 24, 6);
INSERT INTO public.games VALUES (6, 10, 1);
INSERT INTO public.games VALUES (7, 68, 20);
INSERT INTO public.games VALUES (8, 773, 20);
INSERT INTO public.games VALUES (9, 190, 21);
INSERT INTO public.games VALUES (10, 589, 21);
INSERT INTO public.games VALUES (11, 439, 20);
INSERT INTO public.games VALUES (12, 437, 20);
INSERT INTO public.games VALUES (13, 620, 20);
INSERT INTO public.games VALUES (14, 722, 22);
INSERT INTO public.games VALUES (15, 388, 22);
INSERT INTO public.games VALUES (16, 793, 23);
INSERT INTO public.games VALUES (17, 208, 23);
INSERT INTO public.games VALUES (18, 120, 22);
INSERT INTO public.games VALUES (19, 225, 22);
INSERT INTO public.games VALUES (20, 418, 22);
INSERT INTO public.games VALUES (21, 808, 24);
INSERT INTO public.games VALUES (22, 826, 24);
INSERT INTO public.games VALUES (23, 161, 25);
INSERT INTO public.games VALUES (24, 441, 25);
INSERT INTO public.games VALUES (25, 66, 24);
INSERT INTO public.games VALUES (26, 467, 24);
INSERT INTO public.games VALUES (27, 963, 24);
INSERT INTO public.games VALUES (28, 10, 1);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'Tset');
INSERT INTO public.users VALUES (6, 'Tset2');
INSERT INTO public.users VALUES (18, 'user_1657124358387');
INSERT INTO public.users VALUES (19, 'user_1657124358386');
INSERT INTO public.users VALUES (20, 'user_1657124841089');
INSERT INTO public.users VALUES (21, 'user_1657124841088');
INSERT INTO public.users VALUES (22, 'user_1657125002347');
INSERT INTO public.users VALUES (23, 'user_1657125002346');
INSERT INTO public.users VALUES (24, 'user_1657125074528');
INSERT INTO public.users VALUES (25, 'user_1657125074527');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 28, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 25, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

