Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423762AbWJaWbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423762AbWJaWbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423844AbWJaWbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:31:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:17189 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423762AbWJaWbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:31:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=jPebDUDHGb8lTk+E6evFUfK8yrenknQiys4+Y4IO9KZCmLQncF54UHMK3KY0rkVXU3R9RjDJLi9XFokoL6LGEMSluqG3tUpwLPbpi7BHCk0nUAm+md5IxEqYHxQ/ZUGnO7vzyrkpbdJUP1R2QzBF7Hg+AIU1UZvxsGJPj4jweJ4=
Message-ID: <fc94aae90610311431q19a1490asc7f7c3fef2b7036c@mail.gmail.com>
Date: Tue, 31 Oct 2006 22:31:15 +0000
From: "Michael Lothian" <mike@fireburn.co.uk>
To: "John Richard Moser" <nigelenki@comcast.net>
Subject: Re: Suspend to disk: do we HAVE to use swap?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4546C637.5080504@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4546C637.5080504@comcast.net>
X-Google-Sender-Auth: e1ca0adc229e964c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry but don't all these featues exist already in suspend2?

Available at http://www.suspend2.net/

It uses either swap of a file and also does compression

Mike
