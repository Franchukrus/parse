/* Тип функций.                                      */
typedef double (*func_t) (double);

/* Тип данных для связей в цепочке символов.         */
struct symrec
{
  char *name;  /* имя символа                        */
  int type;    /* тип символа: либо VAR, либо FNCT   */
  union
  {
    double var;                  /* значение VAR     */
    func_t fnctptr;              /* значение FNCT    */
  } value;
  struct symrec *next;    /* поле связи              */
};

typedef struct symrec symrec;