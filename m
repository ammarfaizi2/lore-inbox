Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTIHXIT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbTIHXIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:08:19 -0400
Received: from [80.190.232.4] ([80.190.232.4]:10937 "EHLO srv02.rooty.de")
	by vger.kernel.org with ESMTP id S263718AbTIHXIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:08:09 -0400
Message-ID: <002f01c3765e$0f125950$0419a8c0@firestarter.shnet.org>
From: "Dennis Freise" <Cataclysm@final-frontier.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: New ATI FireGL driver supports 2.6 kernel
Date: Tue, 9 Sep 2003 01:07:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Antivirus-Scanned: Clean
X-Spam-Score: 0.0 (/)
X-Spam-Report: 0.0/5.0
	This mail is probably spam.  The original message has been attached
	along with this report, so you can recognize or block similar unwanted
	mail in future.  See http://spamassassin.org/tag/ for more details.
	Content preview:  > > The ATI drivers are NOT binary-only! >
	http://www.codemonkey.org.uk/projects/agp/binary.shtml Mhh, ATI
	seriously sucks. Really. > Linking GPL code to binary .o files, and
	then disabling the > MODULE_LICENSE("GPL") smells pretty fishy to me.
	[...] 
	Content analysis details:   (0.00 points, 5 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > The ATI drivers are NOT binary-only!
> http://www.codemonkey.org.uk/projects/agp/binary.shtml

Mhh, ATI seriously sucks. Really.

> Linking GPL code to binary .o files, and then disabling the
> MODULE_LICENSE("GPL") smells pretty fishy to me.

This whole situation stinks - ATI plays games with open source, using the
free parts to complement their own components and on the other hand prevent
implementation by kernel-developers... maybe there should be more talking
going on between hardware-manufacturers and linux-developers, because my
ATI-GraKa (9800 Pro) STILL does not work - not with 2.4.x, not with 2.6.x,
even with all the newest versions (problem not based on ATI drivers, but on
agpgart KT400 / AGP3 issues)
Since all compoments do work on W*nd*ws, I seriously wonder how much M$ pays
to ATI to prevent linux-driver development.

My apologies for being wrong about the bin-only-part...

Greetings,
Dennis


