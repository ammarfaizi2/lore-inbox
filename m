Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273826AbRI3Rih>; Sun, 30 Sep 2001 13:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273829AbRI3Ri2>; Sun, 30 Sep 2001 13:38:28 -0400
Received: from mail2.aracnet.com ([216.99.193.35]:13837 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S273826AbRI3RiO>; Sun, 30 Sep 2001 13:38:14 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: GCC 2.95, 2.96 and 3.0 on linear algebra (was RE: 2 GB file limitation)
Date: Sun, 30 Sep 2001 10:38:42 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBMENEDNAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010930102342.A13042@vega.digitel2002.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have heard from the Atlas linear algebra folks the following:

1. For compiling Atlas, both on Athlons and Pentia, GCC 2.95.x produces
*significantly* faster operation than either 3.0.x or 2.96.x
2. For IA64, the reverse is true: GCC 3.0.x produces significantly faster
code.

I can dig up the URL for the mailing list if anyone cares for the details.

--
M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
http://www.borasky-research.net  http://www.aracnet.com/~znmeb
mailto:znmeb@borasky-research.net  mailto:znmeb@aracnet.com

Q: How do you tell when a pineapple is ready to eat?
A: It picks up its knife and fork.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Gábor Lénárt
> Sent: Sunday, September 30, 2001 1:24 AM
> To: Luigi Genoni
> Cc: Linux Kernel
> Subject: Re: 2 GB file limitation

[snip]

> > > I think you can get >2GB support if you've Gcc 3.0. Even with
> the latest
> > >
> > ???
> > I am using it and I am using gcc 2.95.3 for normal things,
> > and to compiled my kernel and my libc, because gcc
> > 3.0.1 produces slower binaries on my Athlons (yes, with athlon
> > optimizzations turned on), at less for my programs, and it is better to
> > avoid it for glibc compilation because of back compatibility issues.
>
> Yes, gcc3 is (well at least NOW) a piece of shit. It produces BIGGER and
> SLOWER binaries ... Checked on: Athlon, AMD K6-2.
> With the same gcc command line ...

