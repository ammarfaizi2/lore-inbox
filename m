Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRHJNrh>; Fri, 10 Aug 2001 09:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbRHJNr1>; Fri, 10 Aug 2001 09:47:27 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:19725 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S268071AbRHJNrR>; Fri, 10 Aug 2001 09:47:17 -0400
Date: Fri, 10 Aug 2001 15:47:23 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Christoph Hellwig <hch@caldera.de>
cc: <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
Subject: Re: [ANNOUNCE] Vendor kernels unpakced
In-Reply-To: <20010810151227.A23588@caldera.de>
Message-ID: <Pine.LNX.4.33.0108101519400.1282-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001, Christoph Hellwig wrote:

> On Fri, Aug 10, 2001 at 03:09:51PM +0200, Marco Colombo wrote:
> > On Fri, 10 Aug 2001, Christoph Hellwig wrote:
> >
> > >
> > > I'd like to announce a the availability of unpacked vendor kernel RPMs
> > > on www.kernelnewbies.org.  We allow taking a look at the specfile and
> > > the various patches included in that packages.  Currently the follwing
> > > kernel packages are prvovided (others are of course welcome):
> > >
> > > 	Caldera OpenLinux 3.1 (linux-2.4.2-11)
> > > 	Red Hat Linux 7.1 (kernel-2.4.2-2)
> > >
> > > Please take a look at http://www.kernelnewbies.org/kernels/
> >
> > Please put RH 2.4.3-12 kernel online, instead. I guess that 99% of the
> > people out there that read lk and/or understand what you did, have little
> > interest on an outdated kernel package. Of course this applies to
> > Caldera's kernel updates (if any), too.
>
> I'm not too happy with that as there are just too many kernel updates in
> a product livecycle.

I guess you'll keep the major distro release up to date. These are
the kernel released by RH since 6.2 (not sure of the dates):

kernel-2.2.14-5.0	Mar 2000 - Red Hat 6.2
kernel-2.2.14-12	Apr 2000
kernel-2.2.16-3		Jun 2000

kernel-2.2.16-22	Sep 2000 - Red Hat 7
kernel-2.2.17-1		Feb 2001

kernel-2.4.2-2		Apr 2001 - Red Hat 7.1
kernel-2.4.3-12		Jun 2001

The kernel is a moving target. If you can deal with more than a distribution,
you can deal with 1 or 2 kernel updates per release, IMVHO.

You know, outdated info if useless info.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it


