Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278662AbRKMTyq>; Tue, 13 Nov 2001 14:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278653AbRKMTy1>; Tue, 13 Nov 2001 14:54:27 -0500
Received: from [63.114.153.104] ([63.114.153.104]:57260 "EHLO
	hermes.vegas.itracs.com") by vger.kernel.org with ESMTP
	id <S277380AbRKMTyX>; Tue, 13 Nov 2001 14:54:23 -0500
Message-ID: <001401c16c7c$62bbe4b0$7100020a@vegas.itracs.com>
From: "Kevin Wooten" <kwooten@home.com>
To: "Kai Henningsen" <kaih@khms.westfalen.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20011113171836.A14967@emma1.emma.line.org> <8Cn1lUxXw-B@khms.westfalen.de>
Subject: Re: 2.4.x has finally made it!
Date: Tue, 13 Nov 2001 12:49:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
X-OriginalArrivalTime: 13 Nov 2001 19:50:03.0171 (UTC) FILETIME=[62C1FF30:01C16C7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is he using FreeBSD 4.3? Version 4.4 has been out for quite a
while....that seems like quite an oversight, unless 4.3 performs better than
4.4, which I doubt.


----- Original Message -----
From: "Kai Henningsen" <kaih@khms.westfalen.de>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 13, 2001 10:05 AM
Subject: Re: 2.4.x has finally made it!


> matthias.andree@stud.uni-dortmund.de (Matthias Andree)  wrote on 13.11.01
in <20011113171836.A14967@emma1.emma.line.org>:
>
> > On Tue, 13 Nov 2001, Alastair Stevens wrote:
> >
> > > For those who haven't seen it yet, Moshe Bar at BYTE.com has revisited
his
> > > Linux 2.4 vs FreeBSD benchmarks, using 2.4.12 in this case:
> > >
> > >  http://www.byte.com/documents/s=1794/byt20011107s0001/1112_moshe.html
> >
> > Wow. That person is knowledgeable... NOT. Turning off fsync() for mail
> > is just as good as piping it to /dev/null. See RFC-1123.
>
> I rather think a non-fsync() system has a very much higher rate of
> successful mail deliveries than a /dev/null one, and only slightly (if at
> all) lower than a fsync() one.
>
> Now, that slight difference *can* be rather important if you're a major
> mail hub - or it can be below the noise level in an end user system. In
> either case, however, *nobody* will accept /dev/null as an equivalent
> substitute.
>
> Well, nobody but you.
>
> MfG Kai
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

