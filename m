Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279467AbRKMViF>; Tue, 13 Nov 2001 16:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279462AbRKMVhz>; Tue, 13 Nov 2001 16:37:55 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:27134 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S279418AbRKMVht>; Tue, 13 Nov 2001 16:37:49 -0500
Message-Id: <200111132137.fADLbdW01289@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: "Calin A. Culianu" <calin@ajvar.org>,
        Martin Eriksson <nitrax@giron.wox.org>
Subject: Re: What Athlon chipset is most stable in Linux?
Date: Tue, 13 Nov 2001 16:37:28 -0500
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0111131559580.8219-100000@rtlab.med.cornell.edu>
In-Reply-To: <Pine.LNX.4.30.0111131559580.8219-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've tried a number of boards for our application servers and the only UP 
AMD DDR board I trust right now is the Gigabyte GA-7DX.  They are rock 
solid.

Other AMD 761 boards may work, but I've made too many late night trips to 
the colo to stray from what I know works.  DDR support seems to be the 
breaking point on most boards.

	-- Brian

On Tuesday 13 November 2001 04:08 pm, Calin A. Culianu wrote:
> On Tue, 13 Nov 2001, Martin Eriksson wrote:
> > I'm hearing rumours about my University wanting to set up a cluster
> > with AMD Athlon XP+DDR computers, so I wonder what chipset is most
> > stable under Linux?
> >
> > I assume it's the AMD DDR chipset, but I want to be pretty sure.
> >
> > Btw, do compilators currently optimize for the third floating-point
> > unit in Athlon XP processors?
>
> Well, here's my little anecdote:
>
> We bought 33 1.4 GHz AMD Athlons (non-XP) with the slightly deprecated
> VIA KT266 Chipset (Spacewalker AK31 motherboards.. not exactly the Lexus
> of the M/B world but oh well)..
