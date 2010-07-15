use Test::More qw(no_plan);
use Getopt::Long;

#prove -v t/spreadsheet.t :: -u USERNAME -p PASSWORD

my %h = ();
GetOptions (\%h, 'u=s', 'p=s');  

use Net::Google::Spreadsheets;

my $service = Net::Google::Spreadsheets->new(
	username => $h{u},
	password => $h{p}, 
);

my $spreadsheet = $service->spreadsheet   ( { title => 'perltest' });
my $worksheet   = $spreadsheet->worksheet ( { title => 'Sheet1'   });

my $cell = $worksheet->cell({col => 1, row => 1});

my $old_value = $cell->content();
#is $old_value, '';

my $new_value = "$$ - New";
$cell->input_value($new_value);

is $cell->content, $new_value;

$cell->input_value($old_value);
is $cell->content, $old_value;

