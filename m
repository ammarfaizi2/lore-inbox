Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVE2CMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVE2CMK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 22:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVE2CMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 22:12:10 -0400
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:31979 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261217AbVE2CMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 22:12:06 -0400
Message-ID: <009201c563fb$357ddfb0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Sean M. Burke" <sburke@cpan.org>, <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>
References: <42985251.6030006@cpan.org> <007001c56387$235672d0$2800000a@pc365dualp2> <1117314173.5423.22.camel@mindpipe>
Subject: Re: PATCH: "Ok" -> "OK" in messages
Date: Sat, 28 May 2005 23:04:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Worked many large scale multiple languages translation projects?  I have.
You take what you can get and make it as easy on them as possible to
minimize your own grief.

----- Original Message ----- 
From: "Lee Revell" <rlrevell@joe-job.com>
To: <cutaway@bellsouth.net>
Cc: "Sean M. Burke" <sburke@cpan.org>; <linux-kernel@vger.kernel.org>;
<trivial@rustcorp.com.au>
Sent: Saturday, May 28, 2005 17:02
Subject: Re: PATCH: "Ok" -> "OK" in messages


> On Sat, 2005-05-28 at 09:14 -0400, cutaway@bellsouth.net wrote:
> > printk("The PukeMaster is %sabled.\n", SomeFlag ? "dis" : "en");
> >
> > If a NLS translator isn't a C programmer, they'll screw it up
frequently.
>
> Then you need a better translator.
>
> Lee
>
>

