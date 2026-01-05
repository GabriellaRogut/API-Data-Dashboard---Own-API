document.addEventListener("DOMContentLoaded", () => {

    // -------------------------
    // ELEMENTS
    // -------------------------
    const loadBtn = document.getElementById("loadDataBtn");
    const addBtn = document.getElementById("addDataBtn");
    const downloadPdfBtn = document.getElementById("downloadPdfBtn");

    const tableBody = document.querySelector(".info-table tbody");
    const totalProductsBadge = document.getElementById("total-products");
    const activeCallsBadge = document.getElementById("active-calls");
    const errorsBadge = document.getElementById("errors-today");

    let errorsCount = 0;

    const msgBox = document.getElementById("message-box");
    const msgClose = document.getElementById("MessageClose");
    msgClose.addEventListener("click", () => (msgBox.style.display = "none"));

    // -------------------------
    // BADGES & MESSAGES
    // -------------------------
    function updateBadges() {
        totalProductsBadge.textContent = "Total Products: " + tableBody.rows.length;
        errorsBadge.textContent = "Errors Today: " + errorsCount;
    }

    function setActiveCalls(num) {
        activeCallsBadge.textContent = "Active API Calls: " + num;
    }

    function showSuccess(message) {
        msgBox.style.display = "block";
        msgBox.querySelector(".mssg").innerHTML =
            `<span style="color:green;">&#10004;</span> ${message}`;
        setTimeout(() => {
            msgBox.classList.add("slide-out");
            setTimeout(() => {
                msgBox.classList.remove("slide-out");
                msgBox.style.display = "none";
            }, 600);
        }, 2000);
    }

    // -------------------------
    // LOAD PRODUCTS
    // -------------------------
    loadBtn.addEventListener("click", () => {
        setActiveCalls(1);
        fetch("http://localhost/API-Data-Dashboard-Own-API/API/products.php")
            .then(res => res.json())
            .then(products => {
                tableBody.innerHTML = "";
                products.forEach(p => addProductRow(p));
                updateBadges();
            })
            .catch(err => {
                console.error("Error loading products", err);
                errorsCount++;
                updateBadges();
            })
            .finally(() => setActiveCalls(0));
    });

    // -------------------------
    // ADD ROW
    // -------------------------
    function addProductRow(p, categoryText = p.category?.name || "") {
        const tr = document.createElement("tr");
        tr.innerHTML = `
            <td>${p.id}</td>
            <td><img src="${p.images?.[0] || ""}" alt="${p.title}"></td>
            <td>${p.title}</td>
            <td>$${p.price}</td>
            <td>${categoryText}</td>
            <td>${p.description}</td>
            <td>
                <div class="table-actions">
                    <button class="btn-del"><i class="fa-solid fa-trash"></i> Delete</button>
                    <button class="btn-upd"><i class="fa-solid fa-file-pen"></i> Update</button>
                </div>
            </td>
        `;
        tableBody.appendChild(tr);
    }

    // -------------------------
    // DELETE PRODUCT
    // -------------------------
    const deleteModal = document.getElementById("deleteModal");
    const btnDeleteYes = deleteModal.querySelector(".btn-yes");
    const btnDeleteNo = deleteModal.querySelector(".btn-no");
    const btnDeleteClose = deleteModal.querySelector(".close");

    let rowToDelete = null;

    tableBody.addEventListener("click", (e) => {
        const btn = e.target.closest(".btn-del");
        if (btn) {
            rowToDelete = btn.closest("tr");
            deleteModal.style.display = "flex";
        }

        const btnUpd = e.target.closest(".btn-upd");
        if (btnUpd) openUpdateModal(btnUpd.closest("tr"));
    });

    btnDeleteNo.onclick = btnDeleteClose.onclick = () => {
        deleteModal.style.display = "none";
        rowToDelete = null;
    };

    btnDeleteYes.addEventListener("click", () => {
        if (!rowToDelete) return;
        const id = rowToDelete.cells[0].innerText;
        setActiveCalls(1);
        fetch(`http://localhost/API-Data-Dashboard-Own-API/API/products.php?id=${id}`, { method: "DELETE" })
            .then(() => {
                rowToDelete.remove();
                showSuccess("Item Deleted Successfully.");
                updateBadges();
                deleteModal.style.display = "none";
            })
            .catch(() => { 
                errorsCount++; 
                updateBadges(); 
            })
            .finally(() => setActiveCalls(0));
    });


    // -------------------------
    // UPDATE PRODUCT
    // -------------------------
    const updateModal = document.getElementById("updateModal");
    const updateForm = document.getElementById("updateForm");
    const updateClose = updateModal.querySelector(".close");
    const updateError = updateForm.querySelector(".error-msg");
    const updateSpinner = updateForm.querySelector(".spinner");
    const updateCategorySelect = document.getElementById("updateCategorySelect");
    const addCategorySelect = document.getElementById("addCategorySelect");

    let currentRow = null;
    let currentProductId = null;

    fetch("http://localhost/API-Data-Dashboard-Own-API/API/categories.php")
        .then(res => res.json())
        .then(categories => {
            categories.forEach(cat => {
                updateCategorySelect.innerHTML += `<option value="${cat.id}">${cat.name}</option>`;
                addCategorySelect.innerHTML += `<option value="${cat.id}">${cat.name}</option>`;
            });
        });

    updateClose.onclick = () => {
        updateModal.style.display = "none";
        updateError.style.display = "none";
    };

    function openUpdateModal(row) {
        currentRow = row;
        currentProductId = row.cells[0].innerText;
        updateForm.title.value = row.cells[2].innerText;
        updateForm.price.value = row.cells[3].innerText.replace("$", "");
        updateForm.description.value = row.cells[5].innerText;
        updateForm.image.value = row.cells[1].querySelector("img").src;

        const categoryName = row.cells[4].innerText;
        for (let i = 0; i < updateCategorySelect.options.length; i++) {
            if (updateCategorySelect.options[i].text === categoryName) {
                updateCategorySelect.value = updateCategorySelect.options[i].value;
                break;
            }
        }
        updateModal.style.display = "flex";
    }

    updateForm.addEventListener("submit", (e) => {
        e.preventDefault();
        const title = updateForm.title.value.trim();
        const price = parseFloat(updateForm.price.value);
        const description = updateForm.description.value.trim();
        const image = updateForm.image.value.trim();
        const categoryId = parseInt(updateCategorySelect.value);
        const categoryText = updateCategorySelect.options[updateCategorySelect.selectedIndex].text;

        if (!title || !image || !description || price <= 0) {
            updateError.textContent = "Please fill all fields correctly.";
            updateError.style.display = "block";
            return;
        }

        updateError.style.display = "none";
        updateSpinner.style.display = "inline-block";
        setActiveCalls(1);

        fetch(`http://localhost/API-Data-Dashboard-Own-API/API/products.php?id=${currentProductId}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ title, price, description, categoryId, images: [image] })
        })
        .then(res => res.json())
        .then(updated => {
            currentRow.cells[1].querySelector("img").src = updated.images[0];
            currentRow.cells[2].innerText = updated.title;
            currentRow.cells[3].innerText = "$" + updated.price;
            currentRow.cells[4].innerText = categoryText;
            currentRow.cells[5].innerText = updated.description;
            updateModal.style.display = "none";
            updateBadges();
            showSuccess("Item Updated Successfully.");
        })
        .catch(() => { updateError.innerHTML = "&#9888; Error updating product."; updateError.style.display = "block"; })
        .finally(() => { updateSpinner.style.display = "none"; setActiveCalls(0); });
    });


    // -------------------------
    // ADD PRODUCT
    // -------------------------
    const addModal = document.getElementById("addModal");
    const addForm = document.getElementById("addForm");
    const addClose = document.getElementById("addClose");
    const addError = addForm.querySelector(".error-msg");
    const addSpinner = addForm.querySelector(".spinner");

    addBtn.onclick = () => { 
        addForm.reset(); 
        addModal.style.display = "flex"; 
        addError.style.display = "none"; 
    };
    addClose.onclick = () => { 
        addModal.style.display = "none"; 
        addError.style.display = "none"; 
    };

    addForm.addEventListener("submit", (e) => {
        e.preventDefault();
        const title = addForm.title.value.trim();
        const price = parseFloat(addForm.price.value);
        const description = addForm.description.value.trim();
        const image = addForm.image.value.trim();
        const categoryId = parseInt(addCategorySelect.value);
        const categoryText = addCategorySelect.options[addCategorySelect.selectedIndex].text;

        if (!title || !image || !description || price <= 0) {
            addError.textContent = "Please fill all fields correctly.";
            addError.style.display = "block";
            return;
        }

        addSpinner.style.display = "inline-block";
        setActiveCalls(1);

        fetch("http://localhost/API-Data-Dashboard-Own-API/API/products.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ title, price, description, categoryId, images: [image] })
        })
        .then(res => res.json())
        .then(newProduct => {
            addProductRow(newProduct, categoryText);
            addModal.style.display = "none";
            updateBadges();
            showSuccess("Item Added Successfully.");
        })
        .catch(() => { addError.innerHTML = "&#9888; Error adding product."; addError.style.display = "block"; errorsCount++; })
        .finally(() => { addSpinner.style.display = "none"; setActiveCalls(0); });
    });


    // -------------------------
    // DOWNLOAD PDF
    // -------------------------
    downloadPdfBtn.addEventListener("click", () => {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        const headers = [...document.querySelectorAll(".info-table th")].map(th => th.innerText);
        const rows = [...document.querySelectorAll(".info-table tbody tr")].map(tr => [...tr.cells].map(td => td.innerText));

        doc.autoTable({ head: [headers], body: rows, startY: 10, styles: { fontSize: 8 } });
        doc.save("products.pdf");
    });

});
