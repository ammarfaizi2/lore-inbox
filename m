Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265220AbTLKSIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 13:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbTLKSIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 13:08:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:61312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265220AbTLKSID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 13:08:03 -0500
Date: Thu, 11 Dec 2003 13:10:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: gene.heskett@verizon.net, Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
In-Reply-To: <1316960000.1071164020@[10.10.2.4]>
Message-ID: <Pine.LNX.4.53.0312111304380.5754@chaos>
References: <1071122742.5149.12.camel@idefix.homelinux.org>
 <1071126929.5149.24.camel@idefix.homelinux.org> <1293500000.1071127099@[10.10.2.4]>
 <200312111218.35254.gene.heskett@verizon.net> <1316960000.1071164020@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Martin J. Bligh wrote:

> > Hardware indeed.  I'm a Certified Electronics Technician.  Have
> > someone check all those electrolyric caps in the on-board psu in
> > particular, using a device similar to a "Capacitor Wizard" which
> > measures not the capacity of the cap, but the caps Equivalent Series
> > Resistance (ESR) at 100 kilohertz or more.  Anything over half an ohm
> > should be replaced forthwith.  This assumes of course that your tech
> > in charge of hot solder has the tools to do it correctly.  If not,
> > find one who does have the tools.
> >
> > Many mobos in a period ranging from about 2.5 to 1.5 years ago were
> > built with caps that go defective prematurely due to a bad batch of
> > them from several far eastern cap makers who were fed a bad recipe
> > for the electrolyte in the caps, eg the Ethylene Glycol wasn't near
> > pure enough.
>
> When you say "fed a bad recipe", didn't they actually steal it? Or
> is that just an urban legend?
>
> M.

"Appropriated". Also, it isn't ethylene glycol (that's antifreeze),
It's potassium hydroxide with an inhibitor. The inhibitor was cleverly
removed from the recipe and left out to be stolen. As expected, it
was. Unfortunately, the bad caps didn't damage the competing company
bad enough to put them out-of-business so the whole ploy was a waste
of effort. ;^)


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


