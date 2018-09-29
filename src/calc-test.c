#include <stdarg.h>
#include <stddef.h>
#include <setjmp.h>
#include <cmocka.h>

#include "calc.h"

static void sum_test(void **state) 
{
    assert_int_equal(sum(2, 3), 5);	
    (void) state;
}

static void sub_test(void **state) 
{
    assert_int_equal(sub(2, 5), -3);
    (void) state; 
}


int main(void) 
{
    const struct CMUnitTest tests[] = 
    {
        cmocka_unit_test(sub_test),
        cmocka_unit_test(sum_test),
    };
    return cmocka_run_group_tests(tests, NULL, NULL);
}

