Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280197AbRKNG4R>; Wed, 14 Nov 2001 01:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280195AbRKNG4H>; Wed, 14 Nov 2001 01:56:07 -0500
Received: from [212.3.242.3] ([212.3.242.3]:31504 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S280192AbRKNGz5>;
	Wed, 14 Nov 2001 01:55:57 -0500
Message-Id: <5.1.0.14.2.20011114073740.00a8f3f0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 14 Nov 2001 07:38:11 +0100
To: linux-kernel@vger.kernel.org
From: DevilKin <devilkin@gmx.net>
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <200111132137.fADLbdW01289@demai05.mw.mediaone.net>
In-Reply-To: <Pine.LNX.4.30.0111131559580.8219-100000@rtlab.med.cornell.edu>
 <Pine.LNX.4.30.0111131559580.8219-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been pushing my AMD Abit KG7 board to the limits without crashing, 
using a Thunderbird 1.4.
Don't forget that cooling is also an important issue with these 
processors/motherboards!!

(Mobo is using an AMD 761 AGP Bridge and the rest is from Via ... (don't 
recall, not behind pc)

DK

At 16:37 13/11/2001 -0500, Brian wrote:
>We've tried a number of boards for our application servers and the only UP
>AMD DDR board I trust right now is the Gigabyte GA-7DX.  They are rock
>solid.
>
>Other AMD 761 boards may work, but I've made too many late night trips to
>the colo to stray from what I know works.  DDR support seems to be the
>breaking point on most boards.
>
>         -- Brian
>
>On Tuesday 13 November 2001 04:08 pm, Calin A. Culianu wrote:
> > On Tue, 13 Nov 2001, Martin Eriksson wrote:
> > > I'm hearing rumours about my University wanting to set up a cluster
> > > with AMD Athlon XP+DDR computers, so I wonder what chipset is most
> > > stable under Linux?
> > >
> > > I assume it's the AMD DDR chipset, but I want to be pretty sure.
> > >
> > > Btw, do compilators currently optimize for the third floating-point
> > > unit in Athlon XP processors?
> >
> > Well, here's my little anecdote:
> >
> > We bought 33 1.4 GHz AMD Athlons (non-XP) with the slightly deprecated
> > VIA KT266 Chipset (Spacewalker AK31 motherboards.. not exactly the Lexus
> > of the M/B world but oh well)..

