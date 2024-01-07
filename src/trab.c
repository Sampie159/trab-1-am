#include <stdio.h>

typedef struct {
	float alta;
	float baixa;
} Valor_Nota;

typedef struct {
	float alto;
	float baixo;
} Esforco;

typedef struct {
	float bom;
	float ruim;
} Estado_Mental;

typedef struct {
	float muito;
	float pouco;
} Nota_Necessaria;

typedef struct {
	Valor_Nota valor_nota;
	Esforco esforco;
	Estado_Mental estado_mental;
	Nota_Necessaria nota_necessaria;
} Conjuntos;

typedef enum {
	Certeza,
	Precisa,
	BomFazer,
	NaoPrecisa,
	Descansa,
} Decisao;

static float u_VN(float x) {
	return x < 10 ? 0 : x / 100;
}

static float u_E(float x) {
	return x > 85 ? 0 : (100 - x) / 100;
}

static float u_EM(float x) {
	return x < 10 ? 0 : x / 100;
}

static float u_NN(float x) {
	if (x < 25) return 0;
	else if (x < 50) return .25;
	else if (x < 75) return .50;
	else if (x < 85) return .75;
	else return 1;
}

static void definir_vn(Valor_Nota *vn, float x) {
	vn->alta = u_VN(x);
	vn->baixa = 1 - vn->alta;
}

static void definir_e(Esforco *e, float x) {
	e->alto = u_E(x);
	e->baixo = 1 - e->alto;
}

static void definir_em(Estado_Mental *em, float x) {
	em->bom = u_EM(x);
	em->ruim = 1 - em->bom;
}

static void definir_nn(Nota_Necessaria *nn, float x) {
	nn->muito = u_NN(x);
	nn->pouco = 1 - nn->muito;
}

static void preencher_conjuntos(Conjuntos *c, float entrada[4]) {
	definir_vn(&c->valor_nota, entrada[0]);
	definir_e(&c->esforco, entrada[1]);
	definir_em(&c->estado_mental, entrada[2]);
	definir_nn(&c->nota_necessaria, entrada[3]);
}

static Decisao fazer_escolha(Conjuntos *c) {
	if (c->valor_nota.alta == 1) return Certeza;
	else if (c->valor_nota.baixa == 1) return Descansa;
	else if (c->estado_mental.ruim == 1) return Descansa;
	else if (c->nota_necessaria.muito == 1) return Certeza;

	float fazer = c->esforco.baixo * .15 + c->estado_mental.bom * .25 + c->nota_necessaria.muito * .25 + c->valor_nota.alta * .35;
	
	printf("Fazer: %f\n", fazer);
	
	if (fazer == 1)	return Certeza;
	else if (fazer > .75) return Precisa;
	else if (fazer > .50) return BomFazer;
	else if (fazer > .25) return NaoPrecisa;
	else return Descansa;
}

int main(void) {
	Conjuntos conjuntos = { 0 };
	float vn, e, em, nn;

	printf("Olá, eu sou o Deciditron 3000.\n");
	printf("Decidirei se você deve ou não fazer o trabalho que seu professor passou\n");
	printf("Diga, quanto que vale o trabalho para a sua média [0..100]? ");
	scanf("%f", &vn);
	fflush(stdin);
	printf("%f\n", vn);
	
	printf("E quanto esforço será necessário para fazê-lo [0..100]? ");
	scanf("%f", &e);
	fflush(stdin);
	printf("%f\n", e);

	printf("Como está seu estado mental nesses últimos dias [-100..100]? ");
	scanf("%f", &em);
	fflush(stdin);
	if (em < 0) {
		printf("Coringou\n");
		printf("Cthulhu Fhtagn\n");
	}
	printf("%f\n", em);

	printf("Você precisa de muita nota [0..100]? ");
	scanf("%f", &nn);
	fflush(stdin);
	printf("%f\n", nn);

	float entradas[] = { vn, e, em, nn };
	preencher_conjuntos(&conjuntos, entradas);

	printf("Amigo/a, baseado em tudo que você me disse, acho que você...\n");
	Decisao decisao = fazer_escolha(&conjuntos);

	switch (decisao) {
	case Certeza: printf("Sem dúvida alguma, mãos à massa!\n"); break;
	case Precisa: printf("Precisa fazer sim, boa sorte ;)\n"); break;
	case BomFazer: printf("Seria bom fazer, mas você quem sabe...\n"); break;
	case NaoPrecisa: printf("Não precisa, mas dá uma agregada...\n"); break;
	case Descansa: printf("Vai descansar camarada, você merece :D\n"); break;
	}
}
