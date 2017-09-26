CREATE TABLE Usuario(
	Email VARCHAR(100),
	Nome VARCHAR(100) NOT NULL,
	Senha VARCHAR(100) NOT NULL,
	Profissao VARCHAR(100) NOT NULL,	
	Sexo VARCHAR(10) NOT NULL,
	Foto_Perfil TEXT NOT NULL,
	Cidade VARCHAR(100) NOT NULL,
	Nascimento VARCHAR(10) NOT NULL,
	CONSTRAINT UsuarioPK PRIMARY KEY(Email)
);

CREATE TABLE Lugar(
	ID SERIAL,
	Usuario VARCHAR(100),		
	Nome VARCHAR(100) NOT NULL,	
	Rua VARCHAR(100) NOT NULL,
	Cidade VARCHAR(100) NOT NULL,
	Descricao TEXT NOT NULL,
	Estado VARCHAR(100) NOT NULL,
	Tipo VARCHAR(100) NOT NULL,
	CONSTRAINT LugarPK PRIMARY KEY(ID),
	CONSTRAINT LugarFK FOREIGN KEY(Usuario) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Evento(
	ID SERIAL,
	Usuario VARCHAR(100) NOT NULL,	
	ID_Lugar INT NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Data VARCHAR(10) NOT NULL,	
	Hora VARCHAR(15) NOT NULL,	
	Local VARCHAR(100) NOT NULL,
	Descricao TEXT NOT NULL,
	CONSTRAINT EventoPK PRIMARY KEY(ID),
	CONSTRAINT EventoFK1 FOREIGN KEY(Usuario) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,
	CONSTRAINT EventoFK2 FOREIGN KEY(ID_Lugar) 
		REFERENCES Lugar(ID) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Avaliacao_Lugar(
	ID_Lugar INT,	
	Usuario VARCHAR(100),
	Nota_Lugar INT NOT NULL,
	CONSTRAINT Avaliacao_LugarPK PRIMARY KEY(ID_Lugar, Usuario),
	CONSTRAINT Avaliacao_LugarFK1 FOREIGN KEY (ID_Lugar) 
		REFERENCES Lugar(ID) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,
	CONSTRAINT Avaliacao_LugarFK2 FOREIGN KEY (Usuario) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Presenca_Lugar(	
	ID_Lugar INT,
	Usuario VARCHAR(100),
	Comentario TEXT NOT NULL,	
	Status VARCHAR(50) NOT NULL,
	Data VARCHAR(10),
	CONSTRAINT Presenca_LugarPK PRIMARY KEY(ID_Lugar, Usuario, Data),
	CONSTRAINT Presenca_LugarFK1 FOREIGN KEY(Usuario) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,	
	CONSTRAINT Presenca_LugarFK2 FOREIGN KEY(ID_Lugar) 
		REFERENCES Lugar(ID) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Presenca_Evento(	
	ID_Evento INT,
	Usuario VARCHAR(100),
	Comentario TEXT NOT NULL,	
	Status VARCHAR(50) NOT NULL,
	Data VARCHAR(10),
	CONSTRAINT Presenca_EventoPK PRIMARY KEY(ID_Evento, Usuario, Data),
	CONSTRAINT Presenca_EventoFK1 FOREIGN KEY(Usuario) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,	
	CONSTRAINT Presenca_EventoFK2 FOREIGN KEY(ID_Evento) 
		REFERENCES Evento(ID) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Divulgacao_Evento (
	ID_Evento INT,
	Usuario VARCHAR(100),
	CONSTRAINT Divulgacao_EventoPK PRIMARY KEY(ID_Evento, Usuario),
	CONSTRAINT Divulgacao_EventoK1 FOREIGN KEY(Usuario) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,	
	CONSTRAINT Divulgacao_EventoFK2 FOREIGN KEY(ID_Evento) 
		REFERENCES Evento(ID) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Interacao(
	Usuario_Interaginte VARCHAR(100),
	Usuario_Interagido VARCHAR(100),
	Amizade BOOLEAN NOT NULL,
	Solicitacao_Amizade BOOLEAN NOT NULL,
	CONSTRAINT InteracaoPK PRIMARY KEY(
		Usuario_Interaginte, Usuario_Interagido),
	CONSTRAINT InteracaoFK1 FOREIGN KEY (Usuario_Interagido) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,
	CONSTRAINT InteracaoFK2 FOREIGN KEY (Usuario_Interaginte) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Fotos_Lugar(
	ID_Lugar INT,	
	Foto TEXT,
	CONSTRAINT Fotos_LugarPK PRIMARY KEY(ID_Lugar, Foto),	
	CONSTRAINT Fotos_LugarFK FOREIGN KEY(ID_Lugar) 
		REFERENCES Lugar(ID) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Fotos_Presenca_Lugar(	
	ID_Lugar INT,
	Foto TEXT,
	CONSTRAINT Fotos_Presenca_LugarPK PRIMARY KEY(ID_Lugar, Foto),	
	CONSTRAINT Fotos_Presenca_LugarFK FOREIGN KEY (ID_Lugar) 
		REFERENCES Lugar(ID) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Fotos_Presenca_Evento(	
	ID_Evento INT,
	Foto TEXT,
	CONSTRAINT Fotos_Presenca_EventoPK PRIMARY KEY(ID_Evento, Foto),	
	CONSTRAINT Fotos_Presenca_EventoFK FOREIGN KEY (ID_Evento) 
		REFERENCES Evento(ID) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Mensagem(
	Id SERIAL,	
	Remetente VARCHAR(100),
	Destinatario VARCHAR(100),
	Mensagem TEXT NOT NULL,
	CONSTRAINT MensagemPK PRIMARY KEY(Id, Remetente, Destinatario),	
	CONSTRAINT MensagemFK1 FOREIGN KEY(Remetente) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,
	CONSTRAINT MensagemFK2 FOREIGN KEY(Destinatario) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
);

CREATE TABLE Recomendacao_Lugar(
	Usuario_Recomendador VARCHAR(100),
	Usuario_Destino VARCHAR(100),
	ID_Lugar INT NOT NULL,
	CONSTRAINT Recomendacao_LugarPK PRIMARY KEY(
		Usuario_Recomendador, Usuario_Destino),
	CONSTRAINT Recomendacao_LugarFK1 FOREIGN KEY(Usuario_Recomendador) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,
	CONSTRAINT Recomendacao_LugarFK2 FOREIGN KEY(Usuario_Destino) 
		REFERENCES Usuario(Email) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,
	CONSTRAINT Recomendacao_LugarFK3 FOREIGN KEY(ID_Lugar) 
		REFERENCES Lugar(ID) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE	
);