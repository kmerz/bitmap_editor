# Bitmap editor


# Running

`>bin/bitmap_editor examples/show.txt`

# Usage

## Initializing the canvas

To initilize the canvas with a white background start by adding the `I`
command to the image processing file. It takes to integer arguments:

   * `x` The amoount columns of the bitmap. The value should be between 1 and 255.
   * `y` The amoount rows of the bitmap. The value should be between 1 and 255.

The example creates a white canvas with 5 rows and 6 columns.
```
I 6 5
```

## Clear canvas

To clear a canvas with white pixels add C to the image processing file. This command
does not take any arguments.

The example creates a white canvas with 5 rows and 6 columns and then
clears it to white.
```
I 6 5
C
```

## Print canvas

To print the canvas add S to the image processing file. This command does not
take any arguments.

The example creates a white canvas with 5 rows and 6 columns and then
prints it.
```
I 6 5
S
```

## Set single pixel

Setting a single pixel on the canvas needs the `L` command. It take three
arguments:

   * `x` Integer between 1 and 255 which is used for the coordinate.
   * `y` Integer between 1 and 255 which is used for the coordinate.
   * `c` A color which is present as as a capital letter from A to Z

This example creates a 6 to 5 pixel canvas and sets a pixel to 2 3 in the color A.
After that it prints the result.
```
I 6 5
L 2 3 A
S
```

## Set a vertical line of pixel

To set a vertical line of pixel use the command `V`. It takes four arguments:

   * `x` Integer between 1 and 255 which is used for colomn point.
   * `y1` Integer between 1 and 255 which is row start point.
   * `y2` Integer between 1 and 255 which is row end point.
   * `c` A color which is present as as a capital letter from A to Z

This example creates a 6 to 5 pixel canvas and sets a line in the second colomn
from first to last row.  After that it prints the result.
```
I 6 5
V 2 1 5 A
S
```

## Set a horizontal line of pixel

To set a horizontal line of pixel use the command `H`. It takes four arguments:

   * `x1` Integer between 1 and 255 which is colomn start point.
   * `x2` Integer between 1 and 255 which is column end point.
   * `y`  Integer between 1 and 255 which is row point.
   * `c` A color which is present as as a capital letter from A to Z

This example creates a 6 to 5 pixel canvas and sets a line in the second row
from first to last column.  After that it prints the result.
```
I 6 5
H 2 1 6 A
S
```
