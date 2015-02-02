function validate_form()
{
	if (document.getElementById('first_name').value=='')
	{
		alert("Required Field: First Name");
		document.getElementById('first_name').focus();
		return false;
	}

	else	if (document.getElementById('last_name').value=='')
	{
		alert("Required Field: Last Name");
		document.getElementById('last_name').focus();
		return false;
	}

	else	if (document.getElementById('phone_home').value=='')
	{
		alert("Required Field: Phone");
		document.getElementById('phone_home').focus();
		return false;
	}

	else	if (document.getElementById('address').value=='')
	{
		alert("Required Field: Address");
		document.getElementById('address').focus();
		return false;
	}

	else	if (document.getElementById('zip_code').value=='')
	{
		alert("Required Field: Zip Code");
		document.getElementById('zip_code').focus();
		return false;
	}

	else	if (document.getElementById('city').value=='')
	{
		alert("Required Field: City");
		document.getElementById('city').focus();
		return false;
	}

	else	if (document.getElementById('state').value=='')
	{
		alert("Required Field: State");
		document.getElementById('state').focus();
		return false;
	}

	else	if (document.getElementById('country').value=='')
	{
		alert("Required Field: Country");
		document.getElementById('country').focus();
		return false;
	}

	else	if (document.getElementById('email_address').value=='')
	{
		alert("Required Field: Email Address");
		document.getElementById('email_address').focus();
		return false;
	}

	else	if (document.getElementById('confirmEmail').value=='')
	{
		alert("Required Field: Confirm Email");
		document.getElementById('confirmEmail').focus();
		return false;
	}

	else	if (document.getElementById('program').value=='')
	{
		alert("Required Field: Program of Interest");
		document.getElementById('program').focus();
		return false;
	}

	else	if (document.getElementById('eduLevel').value=='')
	{
		alert("Required Field: Highest Level of Education");
		document.getElementById('eduLevel').focus();
		return false;
	}

	else	if (document.getElementById('gradDate').value=='')
	{
		alert("Required Field: High School Graduation Date");
		document.getElementById('gradDate').focus();
		return false;
	}

	else	if (document.getElementById('military_status').value=='')
	{
		alert("Required Field: US Military Affiliation");
		document.getElementById('military_status').focus();
		return false;
	}

	else	if (document.getElementById('time_zone').value=='')
	{
		alert("Required Field: Time Zone");
		document.getElementById('time_zone').focus();
		return false;
	}

	else	if (document.getElementById('confirm').value=='')
	{
		alert("Required Field: By submitting this form, I acknowledge that American Intercontinental University will contact me via email and telephone.");
		document.getElementById('confirm').focus();
		return false;
	}

	else	if(document.getElementById('leadid_tcpa_disclosure').checked == false)
	{
		alert("Required Field: By clicking the button below, I consent to receive calls and/or text messages from American Intercontinental University and/or Campus Explorer at the phone number(s) I provided, including wireless, using automated call technology. Such consent is not required to attend American Intercontinental University.");
		document.getElementById('leadid_tcpa_disclosure').focus();
		return false;
	}

	return true;
}