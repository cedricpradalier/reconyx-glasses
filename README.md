# reconyx-glasses
3D model of lens holders for the [Reconyx HyperFire](https://www.reconyx.com/product/Outdoor_Series?gad_source=1) cameras.

![Original camera from the manufacturer's website](https://www.trailcampro.com/cdn/shop/products/reconyx_HF2_FA_420_400x.jpg?v=1637358072)

This repository includes some work on 3D models dedicated to attach a lens to the camera. The HyperFire camera is a rugged system designed for wild-life monitoring. As a result, the lens focus is fixed to infinity (a few meters away from the camera) and cannot be changed. In our application where the camera takes pictures of images relatively close to the lens, this leads to blurry images. Although this is not a problem in its normal use case, the camera is far-sighted (or even presbyopic) for our very specific use case (probably outside of the camera specifications in the first place) and it needs prescription glasses. 

## Objectives
In our use case, observing toads, tritons and salamanders in wildlife underpass, the effect is the following:

![Original camera no correction](images/field_no_correction.jpg)

With the proper correction:

![Original camera correction](images/field_50cm_2delta.jpg)

## Designs
The resulting lens holder is designed with [OpenSCAD](https://openscad.org/) to be 3D printed. The SCAD files are in the [scad](scad) folder. The resulting STL files in the [stl](stl) folder.

### Magnetic design
The [third design](stl/reconyx_magnets.stl) is made to be installed on the enclosure and kept in place with magnets. It is not secured as strongly as the previous designs, but much easier to install in cramped condition. This designed is parameterized by the magnet size (10mm diameter, 3mm thickness in the picture below). A 3D view of one version of the design is visible here: 

![camera with magnet 1](images/reconyx_magnets_1.png)

After printing, the magnets need to be inserted in the side flap (purple in the image above) and the flap cover glued (we use a standard office glue with our PLA print). The flap can then be glued to the main body. 

Once the lens is inserted into the design, the top part(dark blue here) is placed on top of it and rotated into place. A small screw (3mm diameter, 10mm length) is then used to secure the assembly. The top cover (light blue here) is used to protect the lens while the assembly is in storage.

A finalized version, can be seen here with the additional engraving, and installed on the camera

![camera with magnet 2](images/IMG_20250224_162453.jpg)

![camera with magnet 3](images/IMG_20250220_101614.jpg)


Note that the design was thought to be printed on a filament printer. If you print in a medium that does not rely on support matterial, you can use this [alternative model](stl/reconyx_magnets_no_support.stl). In this design the magnet flap are rigidly attached to the model.

### Mechanically locked design
The [second design](stl/reconyx_box.stl) is kept in place by the [Reconyx enclosure box](https://www.reconyx.com/product/HyperFire-2-Security-Enclosure).

![camera with clipped lenses CAD](images/reconyx_box_1.png)

The camera, in its enclosure, with the lens on is displayed here:

![camera with box lens](images/IMG_20250211_101950.jpg)

Adding a tiny rubber band forces the lens in place, while keeping a little bit of flexibility when opening or closing the enclosure:

![camera with box lens and rubber](images/IMG_20250211_140146.jpg)

### Direct clip design
The [first design](stl/reconyx_clip.stl) clips on the camera without any enclosure. 
![camera with clipped lenses](images/IMG_20250110_174113.jpg)

![camera with clipped lenses CAD1](images/reconyx_clip_1.png)

![camera with clipped lenses CAD2](images/reconyx_clip_2.png)


## Finding lenses

The proposed model is designed to hold [optometrist test lenses](https://fr.aliexpress.com/item/1703330056.html), which are 38mm wide and 2mm thick. It is relatively easy to find 40mm lenses as [high-school optics material](https://jeulin.com/ovio_fr/pr-323333.html). This can be changed with the Dlens and Tlens variables in the scad files. 

The rule of thumb for selecting the focal or the dioptries is simple. The focal should approximately be equivalent to the distance at which the animals are going to be imaged. The focal resulting from a lens is the inverse of the dioptries, in m. 

Dioptries | Distances
--- | ---
1 | 1.00 m
2 | 0.50 m
2.5 | 0.40 m
3 | 0.33 m
4 | 0.25 m


## Lens testing
After some testing with my [optometrist](https://www.remillyoptic.fr/), this is the effect of choosing glasses from +2.0 to 3.0 dioptries, to observe an object 40cm away from the camera.
Without lenses:
![Naked lens](images/RCNX0023.JPG)

With +2.0 correction:
![+2.0 dioptries](images/RCNX0066.JPG)

With +2.5 correction:
![+2.5 dioptries](images/RCNX0105.JPG)

With +3.0 correction:
![+3.0 dioptries](images/RCNX0135.JPG)


