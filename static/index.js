const aboutLink = document.querySelector("#links button:not([disabled])");
const disabledBtns = document.querySelectorAll("#links button[disabled]");

disabledBtns.forEach((btn) => {
    btn.addEventListener("mouseenter", () =>
        aboutLink.classList.add("opacity-50"),
    );
    btn.addEventListener("mouseleave", () =>
        aboutLink.classList.remove("opacity-50"),
    );
});

const mobileToggle = document.getElementById("mobile-toggle");
const mobileMenu = document.getElementById("mobile-menu");
const mobileIconPath = mobileToggle.querySelector("path");

let isMenuOpen = false;

mobileToggle.addEventListener("click", () => {
    isMenuOpen = !isMenuOpen;
    if (isMenuOpen) {
        mobileMenu.classList.remove("opacity-0", "pointer-events-none");
        mobileIconPath.setAttribute("d", "M6 18L18 6M6 6l12 12");
    } else {
        mobileMenu.classList.add("opacity-0", "pointer-events-none");
        mobileIconPath.setAttribute(
            "d",
            "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5",
        );
    }
});
