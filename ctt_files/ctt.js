

class TTSV {
    constructor(name, mssv, year, degree, program, department, status, gender, s_class, khoa, email, avatar_url) {
        this.name = name;
        this.mssv = mssv;
        this.year = year;
        this.degree = degree;
        this.program = program;
        this.department = department;
        this.status = status;
        this.gender = gender;
        this.s_class = s_class;
        this.khoa = khoa;
        this.email = email;
		this.avatar_url = avatar_url;
    }

	getName() {
		return this.name;
	}

	setName(name) {
		this.name = name;
	}

	getMssv() {
		return this.mssv;
	}

	setMssv(mssv) {
		this.mssv = mssv;
	}

	getYear() {
		return this.year;
	}

	setYear(year) {
		this.year = year;
	}

	getDegree() {
		return this.degree;
	}

	setDegree(degree) {
		this.degree = degree;
	}

	getProgram() {
		return this.program;
	}

	setProgram(program) {
		this.program = program;
	}

	getDepartment() {
		return this.department;
	}

	setDepartment(department) {
		this.department = department;
	}

	getStatus() {
		return this.status;
	}

	setStatus(status) {
		this.status = status;
	}

	getGender() {
		return this.gender;
	}

	setGender(gender) {
		this.gender = gender;
	}

	getS_class() {
		return this.s_class;
	}

	setS_class(s_class) {
		this.s_class = s_class;
	}

	getKhoa() {
		return this.khoa;
	}

	setKhoa(khoa) {
		this.khoa = khoa;
	}

	getEmail() {
		return this.email;
	}

	setEmail(email) {
		this.email = email;
	}

	getAvatar_url() {
		return this.avatar_url;
	}

	setAvatar_url(avatar_url) {
		this.avatar_url = avatar_url;
	}

    log() {
        console.log("Name: " + this.name + "\nMSSV: " + this.mssv);
    }
}

const department_dict = {
	"sme": "Trường Cơ khí",
	"sbft": "Viện Công nghệ Sinh học và Công nghệ Thực phẩm",
	"soict": "Trường Công nghệ Thông tin và Truyền thông",
	"bktextile": "Viện Dệt may - Da giầy và Thời trang",
	"inest": "Viện Khoa học và Công nghệ Môi trường",
	"mse": "Viện Khoa học và Kỹ thuật Vật liệu",
	"sem": "Viện Kinh tế và Quản lý",
	"sce": "Viện Kỹ thuật Hóa học",
	"sofl": "Viện Ngoại ngữ",
	"sepd": "Viện Sư phạm Kỹ thuật",
	"sami": "Viện Toán ứng dụng và Tin học",
	"sep": "Viện Vật lý Kỹ thuật",
	"seee": "Trường Điện - Điện tử",
};

const gender_dict = {
	"male": "Nam",
	"female": "Nữ",
};

const status_dict = {
	"ongoing": "Học",
	"stop": "Thôi học",
};

let me = new TTSV("Trần Vân Ngọc", "20200443", 2020, "Đại học đại trà", "Kỹ thuật Máy tính 2020",
    "soict", "ongoing", "female", "Kỹ thuật máy tính 01-K65", 65, "ngoc.tv200443@sis.hust.edu.vn", "./student-picture.png");

const init_me = new TTSV("Trần Vân Ngọc", "20200443", 2020, "Đại học đại trà", "Kỹ thuật Máy tính 2020",
"soict", "ongoing", "female", "Kỹ thuật máy tính 01-K65", 65, "ngoc.tv200443@sis.hust.edu.vn", "./student-picture.png");
// status: ongoing, stop
// gender: male, female

function disable_edit() {
	const inputs = document.getElementsByTagName("input");
	for (let i = 0; i < inputs.length; i++) {
		inputs[i].setAttribute("disabled", "");
	}
	document.getElementById("me.Department").setAttribute("disabled", "");
}

function hide_button() {
	document.getElementById("button-submit").style.display = "none";
	document.getElementById("button-cancel").style.display = "none";
	document.getElementById("button-reset").style.display = "none";
}

function show_button() {
	document.getElementById("button-submit").style.display = "inline-block";
	document.getElementById("button-cancel").style.display = "inline-block";
	document.getElementById("button-reset").style.display = "inline-block";
}

function display(object) {
	console.log(object);
	document.getElementById("me.Mssv").value = object.getMssv();
	document.getElementById("me.Name").value = object.getName();
	document.getElementById("me.Year").value = object.getYear();
	document.getElementById("me.Degree").value = object.getDegree();
	document.getElementById("me.Program").value = object.getProgram();
	const options_department = document.getElementsByTagName("option");
	for (let i = 0; i < options_department.length; i++) {
		if (options_department[i].value === object.getDepartment()) {
			options_department[i].setAttribute("selected", "");
			break;
		}
	}
	const options_status = document.querySelectorAll('[name="study-status"]');
	for (let i = 0; i < options_status.length; i++) {
		if (options_status[i].value === object.getStatus()) {
			options_status[i].setAttribute("checked", "");
			break;
		}
	}
	const options_gender = document.querySelectorAll('[name="gender"]');
	for (let i = 0; i < options_gender.length; i++) {
		if (options_gender[i].value === object.getGender()) {
			options_gender[i].setAttribute("checked", "");
			break;
		}
	}
	document.getElementById("me.S_class").value = object.getS_class();
	document.getElementById("me.Khoa").value = object.getKhoa();
	document.getElementById("me.Email").value = object.getEmail();
	document.getElementById("student-avatar").src = object.getAvatar_url();
}

function enable_edit() {
	show_button();
	const inputs = document.getElementsByTagName("input");
	for (let i = 0; i < inputs.length; i++) {
		if (inputs[i].hasAttribute("disabled")) {
			inputs[i].removeAttribute("disabled");
		}
	}
	document.getElementById("me.Department").removeAttribute("disabled");
}

function cancel(){
	// console.log(me);
	display(me);
	disable_edit();
	hide_button();
}

function reset(){
	// console.log(init_me);
	display(init_me);
	disable_edit();
	hide_button();
	// document.getElementById('me.Avatar').value = "";
}

function submit(){
	hide_button();
	disable_edit();
	me.setMssv(document.getElementById("me.Mssv").value);
	me.setName(document.getElementById("me.Name").value);
	me.setYear(document.getElementById("me.Year").value);
	me.setDegree(document.getElementById("me.Degree").value);
	me.setProgram(document.getElementById("me.Program").value);
	const options_department = document.querySelectorAll('select[id="me.Department"] > option');
	for (let i = 0; i < options_department.length; i++) {
		if (options_department[i].hasAttribute("selected")) {
			me.setDepartment(options_department[i].value);
			break;
		}
	}
	const options_status = document.querySelectorAll('[name="study-status"]');
	for (let i = 0; i < options_status.length; i++) {
		if (options_status[i].hasAttribute("checked")) {
			me.setStatus(options_status[i].value);
			break;
		}
	}
	const options_gender = document.querySelectorAll('[name="gender"]');
	for (let i = 0; i < options_gender.length; i++) {
		if (options_gender[i].hasAttribute("checked")) {
			me.setGender(options_gender[i].value);
			break;
		}
	}
	me.setS_class(document.getElementById("me.S_class").value);
	me.setKhoa(document.getElementById("me.Khoa").value);
	me.setEmail(document.getElementById("me.Email").value);
	me.setAvatar_url(document.getElementById("student-avatar").src);
	document.getElementById("student-picture-small").src = document.getElementById("student-avatar").src;
	console.log(me);
}