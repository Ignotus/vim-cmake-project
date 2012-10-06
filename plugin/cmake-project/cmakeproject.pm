# vim-cmake-project
# Copyright (C) 2012 Minh Ngo
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
package cmakeproject;
our $version = '0.1';
use File::Find::Rule;
use Cwd;

sub cmake_project_files {
    my $dir = shift;

    my @dependencies = File::Find::Rule->file()
                                    ->name("DependInfo.cmake")
                                    ->in($dir);
    my @accum = ();

    foreach my $filename(@dependencies) {
        open(FILE, $filename);
        my @data = <FILE>;
        push (@accum, src_files(\@data));
        close(FILE);
    }

    return @accum;
}

sub src_files {
    my @result = ();
    foreach my $line(@{(shift)}) {
        if ($line =~ m/\s*\"([a-zA-Z_\/]+)\/([a-zA-Z_]+\.(cpp|cc)).*/) {
            push(@result, { 'dir' => $1, 'file' => $2});
        }
    }
    return @result;
}

1;
