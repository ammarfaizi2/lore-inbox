Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279749AbRKMWju>; Tue, 13 Nov 2001 17:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279782AbRKMWjk>; Tue, 13 Nov 2001 17:39:40 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:17551 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S279749AbRKMWj3>;
	Tue, 13 Nov 2001 17:39:29 -0500
Date: Tue, 13 Nov 2001 17:39:28 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: "Paul G. Allen" <pgallen@randomlogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <3BF19C23.F45EBB50@randomlogic.com>
Message-ID: <Pine.LNX.4.30.0111131738370.8219-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Paul G. Allen wrote:

> Brian wrote:
> >
> > We've tried a number of boards for our application servers and the only UP
> > AMD DDR board I trust right now is the Gigabyte GA-7DX.  They are rock
> > solid.
> >
> > Other AMD 761 boards may work, but I've made too many late night trips to
> > the colo to stray from what I know works.  DDR support seems to be the
> > breaking point on most boards.
> >
>
> Another thing to remember about Athlons is they need power and cooling. I've seen many a system with either a cheap power supply or a poorly ventilated case,
> and often both. Athlons WILL push the hardware harder, not to mention the power they suck down themselves, and need a power supply that can handle the load as
> well as the fast switching transitions. They also require more cooling, and not just on the CPU, but also on the chipset and throughout the case.

Very true.  I think good numbers to shoot for are like around 40-50
degrees C for the CPU temp, probably a bit lower for the M/B temp (like
around high 30's?).

>
> My dual 1.4GHz (K7 Thunder) has 12 fans in it. My single 1.4GHz has 8. They both have 400W+ power supplies.
>
> PGA
>

