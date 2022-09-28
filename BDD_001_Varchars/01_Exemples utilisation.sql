
--------------------------------- ETAPE 1 --------------------------------------------------

-- VARCHAR -> non-unicode --
TRUNCATE TABLE [dbo].[test_varchar];
insert into [dbo].[test_varchar] (label) values ('®');				-- SYMBOLE
insert into [dbo].[test_varchar] (label) values ('¤');				-- SYMBOLE
insert into [dbo].[test_varchar] (label) values ('¼');				-- SYMBOLE UNICODE
insert into [dbo].[test_varchar] (label) values ('Æ');				-- SYMBOLE UNICODE
insert into [dbo].[test_varchar] (label) values ('Þ');				-- SYMBOLE UNICODE
insert into [dbo].[test_varchar] (label) values ('ß');				-- LANGUE ETRANGERE
insert into [dbo].[test_varchar] (label) values ('こんにちは');			-- LANGUE ETRANGERE
insert into [dbo].[test_varchar] (label) values (N'こんにちは');		-- LANGUE ETRANGERE
SELECT TOP 10 '[test_varchar]', * FROM [dbo].[test_varchar] ORDER BY 2;	-- RESULTAT

-- NVARCHAR  -> non-unicode et unicode --
TRUNCATE TABLE [dbo].[test_nvarchar];
insert into [dbo].[test_nvarchar] (label) values ('®');				-- SYMBOLE
insert into [dbo].[test_nvarchar] (label) values ('¤');				-- SYMBOLE
insert into [dbo].[test_nvarchar] (label) values ('¼');				-- SYMBOLE UNICODE
insert into [dbo].[test_nvarchar] (label) values ('Æ');				-- SYMBOLE UNICODE
insert into [dbo].[test_nvarchar] (label) values ('Þ');				-- SYMBOLE UNICODE
insert into [dbo].[test_nvarchar] (label) values ('ß');				-- LANGUE ETRANGERE
insert into [dbo].[test_nvarchar] (label) values ('_こんにちは');		-- LANGUE ETRANGERE
insert into [dbo].[test_nvarchar] (label) values (N'_こんにちは');		-- LANGUE ETRANGERE
SELECT TOP 10 '[test_nvarchar]', [label] FROM [dbo].[test_nvarchar] ORDER BY 2;	-- RESULTAT

