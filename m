Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277528AbRJOMlQ>; Mon, 15 Oct 2001 08:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277527AbRJOMlG>; Mon, 15 Oct 2001 08:41:06 -0400
Received: from lawcv2.lcisp.com ([12.44.138.11]:13329 "EHLO lcisp.com")
	by vger.kernel.org with ESMTP id <S277526AbRJOMkv>;
	Mon, 15 Oct 2001 08:40:51 -0400
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
To: "Stanislav Meduna" <stano@meduna.org>,
        "Kevin Krieser" <kkrieser_list@footballmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: USB stability - possibly printer related
Date: Mon, 15 Oct 2001 07:41:14 -0500
Message-ID: <NDBBLFLJADKDMBPPNBALCEJDGAAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <01Oct15.090303cest.117126@fwetm.etm.at>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will have to reboot to find this out.  However, it was the latest
available a couple months ago when I bought the drive, and found out the
normal BIOS for the regular IDE controllers hung the computer when it hit
the 40GB drive during boot.

-----Original Message-----
From: Stanislav Meduna [mailto:stano@meduna.org]
Sent: Monday, October 15, 2001 2:03 AM
To: Kevin Krieser; linux-kernel@vger.kernel.org
Subject: Re: USB stability - possibly printer related


Hello,


> I know I've attempted to use the same IBM hard drive on the HPT366
> controller with little success.  I got hangups until I moved it back to
the
> secondary IDE controller.

There was a BIOS update targeting problems with the newer IBM drives
on the 366 - what HPT BIOS did give you problems?

> One thing I have noticed is that, with the 2.4 kernels, my system doesn't
> like sharing IRQs as well as the 2.2 kernels. So you may want to see what
> devices share interrupts with your USB controller, and move the cards if
> necessary.

Thanks for a tip - I'll try it. Hopefully the two are not USB and HPT :-S

Regards
--
                                                          Stano




