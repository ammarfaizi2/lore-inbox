Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267038AbUBMPNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267034AbUBMPNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:13:45 -0500
Received: from mail2.allneo.com ([216.185.99.212]:63702 "EHLO mail1.allneo.com")
	by vger.kernel.org with ESMTP id S267038AbUBMPNo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:13:44 -0500
From: "Brad Cramer" <bcramer@callahanfuneralhome.com>
To: <linux-kernel@vger.kernel.org>
Subject: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
Date: Fri, 13 Feb 2004 10:10:40 -0500
Message-ID: <004e01c3f243$8eadc7b0$6501a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need help, First I am not a kernel hacker or a programmer, but I have
asked this question on the Debian mail lists without any answers and have
also e-mail the writer of the driver but the mail comes back so I am turning
to the kernel-list for some help.
 I can not get my scsi hd to work with my tekram dc-390u2w controller and
the sym53c8xx_2 driver under kernel-2.6.2. Everything works great using
kernel-2.4.28 and sym53c8xx driver so I know this is not a hardware issue
with the disk. I have built the sym53c8xx_2 driver into the kernel and have
tried every boot prompt command I could (getting them from the
sym53c8xx_2.txt included with the kernel doc's. This is an external drive
that has /var and /tmp mounted on, so needless to say my system does not
work properly. I have tried Googleing but no luck there either. Could
someone please help shed some light on this as I can't handle to many more
sleepless nights:)
Thanks
Brad


