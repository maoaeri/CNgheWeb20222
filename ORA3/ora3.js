const buttons_add_group = [...document.querySelectorAll('.button-add-group')];
const buttons_add_info = [...document.querySelectorAll('.button-add-info')];
const spans_group_name = document.querySelectorAll('.group-name');

// Add event listeners for double-click
spans_group_name.forEach((spanElement) => {
    // spanElement.innerHTML += '_20200443';
    spanElement.addEventListener('dblclick', () => {
        addEventListenerToSpanGroupName(spanElement);
    });
});

function addEventListenerToSpanGroupName(spanElement) {
    // Replace the span element with an input element
    const inputElement = document.createElement('input');
    inputElement.value = spanElement.innerHTML.replace('_20200443', '');
    spanElement.replaceWith(inputElement);

    // Add event listener for keydown
    inputElement.addEventListener('keydown', (event) => {
        // Check if the Enter key was pressed
        if (event.key === 'Enter') {
            // Replace the input element with a span element
            const newSpanElement = document.createElement('span');
            newSpanElement.innerHTML = inputElement.value + '_20200443';
            inputElement.replaceWith(newSpanElement);
        }
    });
}

function addEventListenerToLabelItemName(labelElement) {
    // Replace the span element with an input element
    const inputElement = document.createElement('input');
    inputElement.value = labelElement.textContent;
    labelElement.replaceWith(inputElement);

    // Add event listener for keydown
    inputElement.addEventListener('keydown', (event) => {
        // Check if the Enter key was pressed
        if (event.key === 'Enter') {
            // Replace the input element with a span element
            const newlabelElement = document.createElement('label');
            newlabelElement.textContent = inputElement.value;
            newlabelElement.style = 'width: 30%;';
            inputElement.replaceWith(newlabelElement);
        }
    });
}

function addEventListenerToButtonsAddInfo(button) {
    console.log(buttons_add_info);
    const parentDiv = button.parentElement.parentElement;
    const nextDiv = parentDiv.nextElementSibling;
    const newLabel = document.createElement('label');
    const newDiv = document.createElement('div');
    newDiv.style = 'display: flex; padding-left: 20px; padding-right: 20px';
    newLabel.textContent = 'Item Info Name';
    newLabel.style = 'width: 30%;';
    newLabel.addEventListener('dblclick', function(){
        addEventListenerToLabelItemName(newLabel);
    })
    const newInput = document.createElement('input');
    newInput.type = 'text';
    newInput.name = 'new-input';
    newInput.id = 'new-input';
    newDiv.appendChild(newLabel);
    newDiv.appendChild(newInput);
    nextDiv.appendChild(newDiv);
}

function addEventListenerToButtonsAddGroup(button) {
    const parent3Div = button.parentElement.parentElement.parentElement;
    const pageContainer = document.createElement('div');

    parent3Div.appendChild(pageContainer);

    pageContainer.classList.add('page_info');

    const pageHeader = document.createElement('div');
    pageHeader.classList.add('page_info_header');

    const pageHeaderLabel = document.createElement('div');
    pageHeaderLabel.classList.add('page_header_label', 'page_main_label');

    const headerSpan = document.createElement('span');
    headerSpan.textContent = 'Group Item_20200443';
    headerSpan.addEventListener('dblclick', () => {
        addEventListenerToSpanGroupName(headerSpan);
    });
    pageHeaderLabel.appendChild(headerSpan);

    const addButton = document.createElement('button');
    addButton.setAttribute('type', 'button');
    addButton.classList.add('button-add-info');
    addButton.textContent = 'Add Info Item';
    addButton.addEventListener('click', function() {
        addEventListenerToButtonsAddInfo(addButton)
    });

    const addGroupButton = document.createElement('button');
    addGroupButton.setAttribute('type', 'button');
    addGroupButton.classList.add('button-add-group');
    addGroupButton.textContent = 'Add Group Item';
    addGroupButton.addEventListener('click', function() {
        addEventListenerToButtonsAddGroup(addButton)
    });

    pageHeaderLabel.appendChild(addButton);
    pageHeaderLabel.appendChild(addGroupButton);

    const hr = document.createElement('hr');
    hr.classList.add('page_header_seperate');

    const div = document.createElement('div');

    pageHeader.appendChild(pageHeaderLabel);
    pageHeader.appendChild(hr);

    pageContainer.appendChild(pageHeader);
    pageContainer.appendChild(div);
}

function exportPDF() {
    
    const studentInfo = document.querySelector('#student-info');
    const pdf = new jsPDF();
    pdf.setFillColor('#FFFFFF');
    pdf.rect(20, 20, pdf.internal.pageSize.width - 40, pdf.internal.pageSize.height - 40, 'F');
    pdf.addHTML(studentInfo, function () {
        // Download the PDF file
        pdf.save('my-file.pdf');
    });
    // pdf.addHTML(studentInfo, function() {
    // 	// Download the PDF file
    // 	pdf.save('my-file.pdf');
    // });
    
    // html2canvas(studentInfo).then(canvas => {
    // 	const pdf = new jsPDF('p', 'pt', 'a4');
    // 	pdf.setFillColor('#FFFFFF');
    // 	pdf.rect(20, 20, pdf.internal.pageSize.width - 40, pdf.internal.pageSize.height - 40, 'F');
    // 	pdf.addImage(canvas.toDataURL('image/png'), 'PNG', 0, 0, pdf.internal.pageSize.width, pdf.internal.pageSize.height);
    // 	pdf.save('my-file.pdf');
    // });
}

buttons_add_info.forEach(function(button) {
    button.addEventListener('click', function() {
        addEventListenerToButtonsAddInfo(button);
    });
});

buttons_add_group.forEach(function(button) {
    button.addEventListener('click', function() {
        addEventListenerToButtonsAddGroup(button);
    });
});
