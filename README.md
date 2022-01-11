# Webbing Spool
3d model of a parametric spool for webbing - availabe at https://www.thingiverse.com/thing:4630397

## Inspiration
I really liked the [climbing webbing spool](https://www.thingiverse.com/thing:2325788) made by [DtEW](https://www.thingiverse.com/dtew/designs) but wanted some changes. Namely - the ability to easily spool off webbing, but their version required the webbing to go through both hubs or gluing the hubs together. So this one desired change led down the rabbit hole to many iterations and other ideas.

## Changes
This model was made from scratch by me in OpenSCAD - even though the base object looks pretty much the same externally.

The spool wheels are still printed individually, but now have a central annular snap-fit joint & pin to hold them together and allow for rotation. Webbing retaining clips were added one wrap/webbing thickness away from central hub.

The model is mostly (all?) parametric, but with little to no in-code error checking. Any number of spool wheel holes can be created, and any width and length webbing can be accommodated. The customizer code has some limitations, but easy enough to change or override those in the code itself. Default facets for creating cylinders is low, so that the object previews quickly. Change it higher in final render, or central hubs proably won't spin around each other smoothly (or at all?).

Future version will hopefully have a MOLLE/generic clip attachment option as well.

## Files
Included in repo are the scad file and STL files for 1 inch wide webbing at 15 foot length.

The included STL files have been printed and do work. They are also the same as available on [Thingiverse](https://www.thingiverse.com/thing:4630397)

* webbingSpool.scad - parametric OpenSCAD file. Most variables should be commented and well explained...
* webbingSpool-bottom.stl - bottom wheel has retaining clips around the central hub which you feed webbing past so it stays in places as you wind up webbing (probably not strictly neccessary). After assembly, this spool rotates as you pull webbing. Print with large wheel on build plate, hub and retaining clips pointing positive Z.
* webbingSpool-top.stl - top wheel that does not rotate. Currently has carabiner clip hole, future TODO will be MOLLE attachment method or at least a generic belt type clip. Print with large wheel on build plate, hub pointing positive Z.
* webbingSpool-peg.stl - central annular (cantilevered?) snap-fit peg. Print with long central axis parallel to build plate. This makes the deformation force (when inserting peg into holes) perpendicular to layer lines.
