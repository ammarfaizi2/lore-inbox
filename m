Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264849AbRFYHFy>; Mon, 25 Jun 2001 03:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRFYHFo>; Mon, 25 Jun 2001 03:05:44 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:42770 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id <S264849AbRFYHFc>; Mon, 25 Jun 2001 03:05:32 -0400
Message-ID: <000d01c0fd45$35022e40$d55355c2@microsoft>
From: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
To: <linux-kernel@vger.kernel.org>
Cc: <joeja@mindspring.com>
In-Reply-To: <E15EQHP-0001ET-00@the-village.bc.nu>
Subject: Re: AMD thunderbird oops
Date: Mon, 25 Jun 2001 11:05:24 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2488.0001
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2488.0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Athlon TB CPUs >= 1000mhz potentially not stable at all because of great
heat-production, without correct hardware maintence - try to check whether
Your cpu overheating or cpu cooler make mighty vibration.

Best regards,
Alexander         mailto:dmor@7ka.mipt.ru
----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: <joeja@mindspring.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, June 25, 2001 10:55 AM
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

