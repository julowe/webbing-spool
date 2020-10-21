# Webbing Spool
3d model of a parametric spool for webbing

## Inspiration
I really liked the [climbing webbing spool](https://www.thingiverse.com/thing:2325788) made by [DtEW](https://www.thingiverse.com/dtew/designs) but wanted some changes. Namely - the ability to easily spool off webbing, but their version required the webbing to go through both hubs or gluing them together. This one desired change led to many iterations and other ideas.

## Changes
This model was made from scratch by me in OpenSCAD - even though the base object looks pretty much the same externally.

The spool wheels are still printed individually, but now have a central annular snap-fit joint & pin to hold them together and allow for rotation. Webbing retaining clips were added one wrap off from central hub.

The model is mostly (all?) parametric, but with little to no in-code error checking. Any number of spool wheel holes can be created, and any width and length webbing can be accommodated.

Future version will hopefully have MOLLE attachment points as well.

This also takes a long time to render. Not sure if there is some dumb code thing making it so, or just too many curves and facets.

## Files
Included in repo are the scad file and STL files for 1 inch wide webbing at 15 foot length.

I have printed small test pieces and major problems seem resolved, but no guarantee this model will work yet.

* webbingSpool.scad - parametric OpenSCAD file. Most variables should be commented and well explained...
* webbingSpool-top.stl - top wheel which rotates as you pull webbing. Includes retaining clips. Print with large wheel on build plate, hub and retaining clips pointing positive Z.
* webbingSpool-bottom.stl - bottom wheel that does not rotate. Currently has carabiner clip hole, future TODO will be MOLLE attachment method. Print with large wheel on build plate, hub pointing positive Z.
* webbingSpool-peg.stl - central annular (cantilevered?) snap-fit peg. Print with long central axis parallel to build plate. This makes the deformation force (when inserting peg into holes) perpendicular to layer lines.
