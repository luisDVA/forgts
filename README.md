
<!-- README.md is generated from README.Rmd. Please edit that file -->

# forgts <img src="man/figures/logo.png" align="right" height="138" alt="" />

<!-- badges: start -->
<!-- badges: end -->

forgts reads a spreadsheet and its formatting information to produce gt
tables with the same cell and text formatting as the input file.

Text and cell formats supported include:

- font face (bold, italic)
- font style (color, underline, strikethrough)
- cell fill
- cell borders (color and width)

Note that formatting in the headers is ignored intentionally in this
package, and that the cell and text formatting is added iteratively on
top of gt defaults.

## Installation

Install the development version of forgts from GitHub:

``` r
# install.packages("remotes")
remotes::install_github("luisDVA/forgts")
```

## Using forgts

The `rodentsheet.xlsx` file that comes with this package looks like
this:

<img src="man/figures/spsheetog.png" width="70%" style="display: block; margin: auto;" />

<br/>

The function `forgts` will read the file and produce a gt object.

``` r
library(forgts)
### 
example_spreadsheet <- system.file("extdata/rodentsheet.xlsx", package = "forgts")
forgts(example_spreadsheet)
```

<div id="zuvvulndzp" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#zuvvulndzp table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#zuvvulndzp thead, #zuvvulndzp tbody, #zuvvulndzp tfoot, #zuvvulndzp tr, #zuvvulndzp td, #zuvvulndzp th {
  border-style: none;
}
&#10;#zuvvulndzp p {
  margin: 0;
  padding: 0;
}
&#10;#zuvvulndzp .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#zuvvulndzp .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#zuvvulndzp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#zuvvulndzp .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#zuvvulndzp .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#zuvvulndzp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#zuvvulndzp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#zuvvulndzp .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#zuvvulndzp .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#zuvvulndzp .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#zuvvulndzp .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#zuvvulndzp .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#zuvvulndzp .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#zuvvulndzp .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#zuvvulndzp .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#zuvvulndzp .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#zuvvulndzp .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#zuvvulndzp .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#zuvvulndzp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#zuvvulndzp .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#zuvvulndzp .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#zuvvulndzp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#zuvvulndzp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#zuvvulndzp .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#zuvvulndzp .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#zuvvulndzp .gt_left {
  text-align: left;
}
&#10;#zuvvulndzp .gt_center {
  text-align: center;
}
&#10;#zuvvulndzp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#zuvvulndzp .gt_font_normal {
  font-weight: normal;
}
&#10;#zuvvulndzp .gt_font_bold {
  font-weight: bold;
}
&#10;#zuvvulndzp .gt_font_italic {
  font-style: italic;
}
&#10;#zuvvulndzp .gt_super {
  font-size: 65%;
}
&#10;#zuvvulndzp .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#zuvvulndzp .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#zuvvulndzp .gt_indent_1 {
  text-indent: 5px;
}
&#10;#zuvvulndzp .gt_indent_2 {
  text-indent: 10px;
}
&#10;#zuvvulndzp .gt_indent_3 {
  text-indent: 15px;
}
&#10;#zuvvulndzp .gt_indent_4 {
  text-indent: 20px;
}
&#10;#zuvvulndzp .gt_indent_5 {
  text-indent: 25px;
}
&#10;#zuvvulndzp .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#zuvvulndzp div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="measurement-type">measurement type</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="species">species</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="sex">sex</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="CBL">CBL</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="LR">LR</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="measurement type" class="gt_row gt_left" style="font-style: italic;">craniodental</td>
<td headers="species" class="gt_row gt_left">Abeomelomys sevia</td>
<td headers="sex" class="gt_row gt_left" style="font-style: italic;">m</td>
<td headers="CBL" class="gt_row gt_right" style="font-weight: bold;">30.10</td>
<td headers="LR" class="gt_row gt_right">9.65</td></tr>
    <tr><td headers="measurement type" class="gt_row gt_left">craniodental</td>
<td headers="species" class="gt_row gt_left" style="text-decoration: underline;">Bandicota bengalensis</td>
<td headers="sex" class="gt_row gt_left">f</td>
<td headers="CBL" class="gt_row gt_right">39.41</td>
<td headers="LR" class="gt_row gt_right" style="background-color: #F10D0C; color: #168253;">11.21</td></tr>
    <tr><td headers="measurement type" class="gt_row gt_left" style="background-color: #FFFF00;">craniodental</td>
<td headers="species" class="gt_row gt_left">Chiruromys forbesi</td>
<td headers="sex" class="gt_row gt_left" style="color: #F10D0C;">m</td>
<td headers="CBL" class="gt_row gt_right" style="border-top-width: 1px; border-top-style: solid; border-top-color: #5B277D; border-right-width: 1px; border-right-style: solid; border-right-color: #5B277D; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #5B277D; border-left-width: 1px; border-left-style: solid; border-left-color: #5B277D;">30.73</td>
<td headers="LR" class="gt_row gt_right">8.27</td></tr>
    <tr><td headers="measurement type" class="gt_row gt_left" style="font-weight: bold;">craniodental</td>
<td headers="species" class="gt_row gt_left" style="font-weight: bold;">Chiruromys forbesi</td>
<td headers="sex" class="gt_row gt_left">m</td>
<td headers="CBL" class="gt_row gt_right">34.46</td>
<td headers="LR" class="gt_row gt_right" style="font-weight: bold;">8.13</td></tr>
    <tr><td headers="measurement type" class="gt_row gt_left">craniodental</td>
<td headers="species" class="gt_row gt_left" style="border-top-width: 1px; border-top-style: solid; border-top-color: #000000; border-right-width: 1px; border-right-style: solid; border-right-color: #000000; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #000000; border-left-width: 1px; border-left-style: solid; border-left-color: #000000;">Chiruromys lamia</td>
<td headers="sex" class="gt_row gt_left">m</td>
<td headers="CBL" class="gt_row gt_right" style="background-color: #729FCF;">29.56</td>
<td headers="LR" class="gt_row gt_right">8.13</td></tr>
    <tr><td headers="measurement type" class="gt_row gt_left" style="background-color: #729FCF;">craniodental</td>
<td headers="species" class="gt_row gt_left" style="text-decoration: line-through;">Chiruromys lamia</td>
<td headers="sex" class="gt_row gt_left" style="text-decoration: underline;">m</td>
<td headers="CBL" class="gt_row gt_right">27.45</td>
<td headers="LR" class="gt_row gt_right">7.13</td></tr>
    <tr><td headers="measurement type" class="gt_row gt_left" style="text-decoration: underline;">craniodental</td>
<td headers="species" class="gt_row gt_left">Chiruromys vates</td>
<td headers="sex" class="gt_row gt_left">m</td>
<td headers="CBL" class="gt_row gt_right">28.70</td>
<td headers="LR" class="gt_row gt_right" style="font-weight: bold;">7.04</td></tr>
  </tbody>
  &#10;  
</table>
</div>

<br/>

`forgts()` may be used in RMarkdown and Quarto documents, and the
resulting gt tables may be exported with `gt::gtsave()`.
