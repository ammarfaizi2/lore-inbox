Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVLZW1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVLZW1D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVLZW1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:27:01 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35201 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750746AbVLZW1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:27:00 -0500
Date: Mon, 26 Dec 2005 23:26:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Steven Rostedt <rostedt@goodmis.org>, Jaco Kroon <jaco@kroon.co.za>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
 support (try 2)
In-Reply-To: <200512261535.09307.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0512262323110.12671@yvahk01.tjqt.qr>
References: <43AF7724.8090302@kroon.co.za> <43AFB005.50608@kroon.co.za>
 <1135607906.5774.23.camel@localhost.localdomain> <200512261535.09307.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> I use pine and evolution.  Pine is text based and great when I ssh into
>> my machine to work.  Evolution is slow, but plays well with pine and it
>> handles things needed for LKML very well. (the drop down menu "Normal"
>> may be changed to "Preformat", which allows of inserting text files
>> "as-is").
>
>Dare I say it, KMail has also been doing the Right Thing for a long time. It 
>will only line wrap things that you insert by typing; pastes are left 
>untouched.
>
>This satisfies Linus's demand that all patches be part of the email body and 
>not an attachment.


Do not always blame the MUA, because actually, the MTAs may do anything 
with the mail text. That's (among other reasons) why things like MIME 
attachments were invented, because they (their respective uuencoded or 
base64encoded "text") can be wrapped but does not change the 
decoded form.  - Something like that is in the pine doc.



Jan Engelhardt
-- 
