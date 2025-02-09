import PhotoSwipeLightbox from "{{ LIBRARIES['photoswipe-lightbox']['url']['js'] | replace: '{{version}}', LIBRARIES['photoswipe-lightbox']['version'] }}";
import PhotoSwipe from "{{ LIBRARIES['photoswipe']['url']['js'] | replace: '{{version}}', LIBRARIES['photoswipe']['version'] }}";
const photoswipe = new PhotoSwipeLightbox({
  gallery: ".pswp-gallery",
  children: "a",
  pswpModule: PhotoSwipe,
});
photoswipe.init();