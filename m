Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSGHWcE>; Mon, 8 Jul 2002 18:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317209AbSGHWcD>; Mon, 8 Jul 2002 18:32:03 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:6975 "EHLO devil.stev.org")
	by vger.kernel.org with ESMTP id <S317194AbSGHWcC>;
	Mon, 8 Jul 2002 18:32:02 -0400
Message-ID: <00dc01c226cf$50825640$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Andy" <ahaning@mindspring.com>, <linux-kernel@vger.kernel.org>
References: <200207082159.WAA03443@darkstar.example.net> <006101c226ca$d0c9a380$0501a8c0@Stev.org> <3D29D540.3080001@mindspring.com>
Subject: Re: ATAPI + cdwriter problem
Date: Mon, 8 Jul 2002 23:32:14 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > its a Benq 32x10x40 CD/RW
> Check here for your drive to see if there are any updates for it:
> http://perso.club-internet.fr/farzeno/firmware/cdr/cdrf.htm

will have a look.

> > running with the Promise ATA/133 controller
> If the drive is not ATA/### where ### is 66/100/133, then you may try
> putting the drive on a UDMA/33 port to see if that helps at all. (So you
> could eliminate the ATA/133 port as being part of the problem.

2 of the drives are on a UDMA/33 controller and i still have problems with
them
always have but they worked fine under 2.2.x i have always had problems in
2.4.x
i tend to post here every few months when it gets me pissed of about it
though this
is about the biggest response i have ever seen so far.

i can also see sombody else may have the same problems with ide-scsi but
with a
dvd drive it matches what i see with a drive when reading bad media.

http://mail.nl.linux.org/linux-mm-bugs/2002-01/msg00000.html

    James


