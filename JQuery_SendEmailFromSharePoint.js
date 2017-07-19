function sendEmail(from, to, body, subject) {
    //Get the relative url of the site
    
    var urlTemplate = "https://toyotaleasingthailand.sharepoint.com/_api/SP.Utilities.Utility.SendEmail";
    $.ajax({
        contentType: 'application/json',
        url: urlTemplate,
        type: "POST",
        data: JSON.stringify({
            'properties': {
                '__metadata': {
                    'type': 'SP.Utilities.EmailProperties'
                },
                'From': from,
                'To': {
                    'results': [to]
                },
                'Body': body,
                'Subject': subject
            }
        }),
        headers: {
            "Accept": "application/json;odata=verbose",
            "content-type": "application/json;odata=verbose",
            "X-RequestDigest": jQuery("#__REQUESTDIGEST").val()
        },
        success: function(data) {
            alert('Email Sent Successfully');
        },
        error: function(err) {
            alert('Error in sending Email: ' + JSON.stringify(err));
        }
    });
}