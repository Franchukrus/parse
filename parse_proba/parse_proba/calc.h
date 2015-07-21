/* ��� �������.                                      */
typedef double(*func_t) (double);

/* ��� ������ ��� ������ � ������� ��������.         */
struct symrec
{
	char *name;  /* ��� �������                        */
	int type;    /* ��� �������: ���� VAR, ���� FNCT   */
	union
	{
		double var;                  /* �������� VAR     */
		func_t fnctptr;              /* �������� FNCT    */
	} value;
	struct symrec *next;    /* ���� �����              */
};

typedef struct symrec symrec;

/* ������� ��������: ������� `struct symrec'.        */
extern symrec *sym_table;

symrec *putsym(const char *, func_t);
symrec *getsym(const char *);