Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSJAIL0>; Tue, 1 Oct 2002 04:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261525AbSJAIL0>; Tue, 1 Oct 2002 04:11:26 -0400
Received: from rammstein.mweb.co.za ([196.2.53.175]:56009 "EHLO
	rammstein.mweb.co.za") by vger.kernel.org with ESMTP
	id <S261524AbSJAILZ>; Tue, 1 Oct 2002 04:11:25 -0400
To: Thomas Molina <tmolina@cox.net>,
       Felipe Alfaro Solana <felipe_alfaro@msn.com>,
       linux-kernel@vger.kernel.org
From: bonganilinux@mweb.co.za
Subject: Re: cdrecord, IDE-SCSI and 2.5.39
Date: Tue, 1 Oct 2002 08:16:39 GMT
X-Posting-IP: 196.34.86.10 via 172.24.158.16
X-Mailer: Endymion MailMan  
Message-Id: <E17wI3a-0001NA-00@rammstein.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Which kernel are you running? I have compiled ide-scsi support into
> > 2.5.39 and I get an Oops after booting.
> > 
> 
> I'm using kernel 2.5.39.  I've used various flavors of linus' bk tree and 
> haven't seen any problems.  However, upon further review, I can cause oops 
> on request when rmmod sr_mod or ide-scsi.  I'm going to write up a full 
> report tomorrow, but it is similar to what others have reported.  I have 
> to get up at 0230 in the morning so it's time for bed now.

Hi,

Have you tried to build ide-scsi support into the kernel? I will
try to compile the kernel with ide-scsi support as modules and see
how it goes when I get home. I did write down the oops that i get
and posted it on the list. I haven't got any feed back on it yet.

The original post of the Oops is here
http://www.uwsg.iu.edu/hypermail/linux/kernel/0209.3/1493.html

Thanx

---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
Are you ready for 10-digit dialling?
To find out how this will affect your Internet connection go to www.mweb.co.za/ten
http://airmail.mweb.co.za/


