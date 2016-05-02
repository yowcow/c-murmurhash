use v6;
use NativeCall;
use Test;

sub library { 'resources/libbloom.so' }

sub init-rand()
    is native(&library)
    is symbol('BF_init_mt')
    { * }

sub real-rand(--> num64)
    is native(&library)
    is symbol('BF_generate_real_rand')
    { * }

sub get-filter-cells(
    CArray[uint32],
    Str,
    uint32,
    CArray[num64],
    uint32,
    uint32 --> CArray[uint32]
    )
    is native(&library)
    is symbol('BF_get_filter_cells')
    { * }

sub filter-cells(Cool:D :$key, CArray[num64] :$seeds, Int:D :$filter-length --> CArray[uint32]) {
    my $cells = CArray[uint32].new;
    $cells[$seeds.elems - 1] = 0;

    get-filter-cells(
        $cells,
        $key,
        $key.chars,
        $seeds,
        $seeds.elems,
        $filter-length,
    );

    $cells;
}


subtest {
    lives-ok { init-rand() };
}, 'Test init-rand';

subtest {
    ok 0.0 <= real-rand() < 1.0;
    ok 0.0 <= real-rand() < 1.0;
    ok 0.0 <= real-rand() < 1.0;
    ok 0.0 <= real-rand() < 1.0;
}, 'Test real-rand';

subtest {
    my $filter-length = 128;
    my $key    = 'hogehoge';
    my @seeds := CArray[num64].new((for 1 .. 100 { real-rand() }));

    my $cells = filter-cells(
        :$key,
        :@seeds,
        :$filter-length,
    );

    for 0 .. $cells.elems - 1 {
        ok 0 <= $cells[$_] < $filter-length, "{$cells[$_]} is within expected range";
    }

}, 'Test filter-cells';

done-testing;
