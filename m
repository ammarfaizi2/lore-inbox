Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130265AbRBZOeX>; Mon, 26 Feb 2001 09:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbRBZOcM>; Mon, 26 Feb 2001 09:32:12 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130215AbRBZO3U>;
	Mon, 26 Feb 2001 09:29:20 -0500
Date: Mon, 26 Feb 2001 12:32:32 +0100 (MET)
From: Robert Kaiser <rob@sysgo.de>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-kernel@vger.kernel.org, eccesys@topmail.de
Subject: Re: Disk is cheap?
In-Reply-To: <20010224145935.D5160@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.21.0102261204240.9294-100000@dagobert.svc.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Feb 2001, Ralf Baechle wrote:

> On Wed, Jan 31, 2001 at 02:29:54PM +0100, Robert Kaiser wrote:
> 
> > Perhaps a more convincing argument may be that in embedded devices,
> > disk as well as memory and CPU power are _not_ cheap.
> > 
> > The more resources Linux requires, the less are it's chances of being
> > accepted as a viable alternative in embedded systems.
> > 
> > > I'm still stuck with a P-133, 56 MB RAM (60-70 ns, some EDO,
> > > some FPM) and not only Linux but also W2K on a 2.1 and a 0.8 GB
> > > HDD.
> > 
> > That would be _a_ _lot_ for an embedded system!
> 
> Oh this common missconception that embedded system equals small systems.

I didn't say that. I'm talking about what's common in embedded systems
and it is _very_ common for an embedded system to be small both in
mechanical dimension and computational horsepower. This is not a
misconception but simply practical experience.

> There are embedded systems that outrun supercomputers without sweating,
> have gigs of RAM and sometimes if you look at them closly even have the
> names of well known big iron companies on their boards.

Sure these systems exist, but trust me, they are a very small fraction
of a very big market.

> The whole
> embedded term is just so weakly defined and everybody seem to have his
> personal definition

How about this: An embedded system is a computer system designed to
fulfill a particular purpose.

Since embedded systems are usually made in large quantities, there is a
strong pressure to make them as cheap as possible. Thus, the amount
of resources assigned to a system is usually just barely enough for
it to fulfill it's purpose. If it has gigs of RAM, you can be sure it
needs every bit of it for doing whatever it is supposed to do.

Running on low resources is symptomatic to all embedded systems.

Helau

Rob

----------------------------------------------------------------
Robert Kaiser                          email: rkaiser@sysgo.de
SYSGO RTS GmbH                         http://www.elinos.com
Am Pfaffenstein 14                     http://www.sysgo.de
D-55270 Klein-Winternheim / Germany    

