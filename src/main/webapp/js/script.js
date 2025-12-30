function scrollCarousel(direction) {
    const track = document.getElementById('heroTrack');

    // Safety check: if track doesn't exist, stop (prevents errors on other pages)
    if (!track) return;

    const slideWidth = track.clientWidth; // Gets the width of one slide

    // Scroll left or right based on direction (-1 or 1)
    track.scrollBy({
        left: direction * slideWidth,
        behavior: 'smooth'
    });
}