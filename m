Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283473AbRLDOog>; Tue, 4 Dec 2001 09:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283438AbRLDOmo>; Tue, 4 Dec 2001 09:42:44 -0500
Received: from fepE.post.tele.dk ([195.41.46.137]:43474 "EHLO
	fepE.post.tele.dk") by vger.kernel.org with ESMTP
	id <S284363AbRLDO0T>; Tue, 4 Dec 2001 09:26:19 -0500
Message-ID: <002701c17d17$d412b480$0b00a8c0@runner>
From: "Rune Petersen" <rune.mail-list@mail.tele.dk>
To: "kernel list" <linux-kernel@vger.kernel.org>
Subject: Fw: ACPI+HP omnibook -- freeze until power is pressed?
Date: Tue, 4 Dec 2001 15:03:03 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: Rune Petersen <rune.mail-list@mail.tele.dk>
To: Pavel Machek <pavel@suse.cz>
Sent: Tuesday, December 04, 2001 3:02 PM
Subject: Re: ACPI+HP omnibook -- freeze until power is pressed?


> yes, but looking closer ACPI doesn't start because of APM: "ACPI: APM is
> already active, exiting"
>
> does this mean that I can't use idle and ACPI at the same time
>
> as far as the freeze problem, I don't know if its still there.
>
> Rune Petersen
> ----- Original Message -----
> From: Pavel Machek <pavel@suse.cz>
> To: Rune Petersen <rune.mail-list@mail.tele.dk>
> Cc: Pavel Machek <pavel@suse.cz>; kernel list
<linux-kernel@vger.kernel.org>
> Sent: Monday, December 03, 2001 12:10 PM
> Subject: Re: ACPI+HP omnibook -- freeze until power is pressed?
>
>
> > Hi!
> >
> > > I've experiensed something with my laptop (Uniwill):
> > > It sometimes locks up when I've booted up, and the powerbutton
sometimes
> > > help, other times it just powers off.
> > > it has happend for me since kernel 2.4.3, but since by laptop is buggy
I
> > > thought it something wrong with it. seams I was wrong..
> >
> > Do you use ACPI?
> > Pavel
> > --
> > "I do not steal MS software. It is not worth it."
> >                                 -- Pavel Kankovsky
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>


