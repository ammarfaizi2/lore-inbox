Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265932AbRFZHqx>; Tue, 26 Jun 2001 03:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265934AbRFZHqn>; Tue, 26 Jun 2001 03:46:43 -0400
Received: from pop.gmx.net ([194.221.183.20]:2007 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265932AbRFZHqd>;
	Tue, 26 Jun 2001 03:46:33 -0400
Message-ID: <031801c0fe13$65814be0$0301a8c0@none56n4x0fcnq>
From: "Thomas Kotzian" <thomasko321k@gmx.at>
To: <joeja@mindspring.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E15EQHP-0001ET-00@the-village.bc.nu>
Subject: Re: AMD thunderbird oops
Date: Tue, 26 Jun 2001 09:39:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as i've said before - i have the same problem too

the memory is OK! - have run memtest86 for hours ... - no errors ... -
heatsink - CPU@45°C - Case @ 25°C

after changing the kernel compile to PentiumII (nearly) everything worked
fine ....

2.4.6pre5 works as PentiumII but not as Athlon
2.4.5ac16 doesn't work at all - random oopses ......

ThomasK.

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: <joeja@mindspring.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, June 25, 2001 8:55 AM
Subject: Re: AMD thunderbird oops


> > I just upgradede my system to an 1200Mhz AMD Athlon Thundirbird (266Mhz
FSB) processor  / 512Meg of RAM, and an Asus kt7a motherboard.
> >
> > It is oppsing left and right.  I recompiled the kernel with Athelon as
the CPU but keep getting these oopses..
> >
> > I also get these same problems while trying to install RH 7.1
> >
> > Anyone know is this a supported processor / MB and has anyone had these
problems?
>
> Random oopses normally indicate faulty board cpu or ram (and the fault may
> even just be overheating or dimms not in the sockets cleanly). I doubt its
> the board design or model that is the problem, you probably jut have a
faulty
> component somewhere if its oopsing randomly even during installs and stuff
>
> memtest86, and heatsink compound may be your best friends
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

