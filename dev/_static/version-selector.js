document.addEventListener("DOMContentLoaded", function () {
    const versions = ["v1.0", "v1.1", "latest", "dev"]; // Replace with actual versions
    const baseUrl = window.location.origin + "/dsa/";

    const select = document.createElement("select");
    select.id = "version-selector";
    select.style.margin = "10px";

    versions.forEach(version => {
        const option = document.createElement("option");
        option.value = version;
        option.textContent = version;
        if (window.location.pathname.includes(version)) {
            option.selected = true;
        }
        select.appendChild(option);
    });

    select.addEventListener("change", function () {
        const selectedVersion = select.value;
        window.location.href = baseUrl + selectedVersion + "/";
    });

    // Add the selector to the sidebar under the menu
    const sidebar = document.querySelector(".sphinxsidebarwrapper");
    if (sidebar) {
        const div = document.createElement("div");
        div.id = "version-selector-container";
        div.appendChild(select);
        sidebar.appendChild(div);
    }
});
