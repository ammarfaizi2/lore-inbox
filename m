Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSDEBBU>; Thu, 4 Apr 2002 20:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310224AbSDEBBL>; Thu, 4 Apr 2002 20:01:11 -0500
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:8206 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S310190AbSDEBAy>; Thu, 4 Apr 2002 20:00:54 -0500
Message-ID: <010b01c1dc3d$49125ae0$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: <joeja@mindspring.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E16tHTh-00078b-00@the-village.bc.nu>
Subject: Re: faster boots?
Date: Thu, 4 Apr 2002 17:00:23 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Sent: Thursday, April 04, 2002 4:21 PM
Subject: Re: faster boots?


> >     Is there some way of making the linux kernel boot faster?  
> 
> #1: Start less crap at boot time. Obvious but thats frequently most of
>     the issue.
> 
> For Red Hat if your hardware set up is constant then rpm -e kudzu will do
> no harm and avoid the grovelling through the box looking for new toys.
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
rotfl, btw.  oh my aching sides.  I may have to quote
that.  reminds me of windows 95 hardware detection

May I suggest chkconfig --level 2345 kudzu off, a less invasive way
to achieve this, without burning bridges.  /sbin/kudzu can still be run
manually then, if the hardware does change and you're lazy (and you
trust kudzu :)

Jeremy
