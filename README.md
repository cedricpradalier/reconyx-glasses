# reconyx-glasses
3D model of lens holders for the [Reconyx HyperFire](https://www.reconyx.com/product/Outdoor_Series?gad_source=1) cameras.

![Original camera from the manufacturer's website](https://www.trailcampro.com/cdn/shop/products/reconyx_HF2_FA_420_400x.jpg?v=1637358072)

This repository includes some work on 3D models dedicated to attach a lens to the camera. The HyperFire camera is a rugged system designed for wild-life monitoring. As a result, the lens focus is fixed to infinity (a few meters away from the camera) and cannot be changed. In our application where the camera takes pictures of images relatively close to the lens, this leads to blurry images. The camera is far-sighted (or even presbyopic) and needs correction glasses. 

After some testing with my optometrist, this is the effect of choosing glasses from +2.0 to 3.5 dioptries, to observe an object 40cm away from the camera.
Without lenses:
![Naked lens](images/RCNX0023.JPG)

With +2.0 correction:
![+2.0 dioptries](images/RCNX0066.JPG)

With +2.5 correction:
![+2.5 dioptries](images/RCNX0105.JPG)

With +3.0 correction:
![+3.0 dioptries](images/RCNX0135.JPG)

The resulting lens holder is designed with [OpenSCAD](https://openscad.org/) to be 3D printed. The SCAD files are in the [scad](scad) folder. The resulting STL files in the [stl](stl) folder.

The first design (reconyx_clip.scad) clips on the camera without any enclosure. 
![camera with clipped lenses](images/IMG_20250110_174113.jpg)

![camera with clipped lenses CAD1](images/reconyx_clip_1.png)

![camera with clipped lenses CAD2](images/reconyx_clip_2.png)

The second design (reconyx_box.scad) is kept in place by [Reconyx enclosure box](https://www.reconyx.com/product/HyperFire-2-Security-Enclosure).

![camera with clipped lenses CAD2](images/reconyx_box_1.png)
