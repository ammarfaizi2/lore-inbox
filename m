Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288293AbSACUFe>; Thu, 3 Jan 2002 15:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288299AbSACUFT>; Thu, 3 Jan 2002 15:05:19 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:17676 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S288294AbSACUFI>;
	Thu, 3 Jan 2002 15:05:08 -0500
Date: Thu, 3 Jan 2002 10:46:06 +0000
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrew Morton <akpm@zip.com.au>, Legacy Fishtank <garzik@havoc.gtf.org>,
        Keith Owens <kaos@ocs.com.au>, Mike Castle <dalgoda@ix.netcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system
Message-ID: <20020103104605.A37@toy.ucw.cz>
In-Reply-To: <20011229042139.GC14067@thune.mrc-home.com> <20011229024143.A11696@havoc.gtf.org> <3C2D7B2B.C1362850@zip.com.au> <E16KFyl-0000DL-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16KFyl-0000DL-00@starship.berlin>; from phillips@bonn-fries.net on Sat, Dec 29, 2001 at 10:40:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > On Sat, Dec 29, 2001 at 03:44:10PM +1100, Keith Owens wrote:
> > > > What Mr. Fishtank seems to overlook is that kbuild 2.5 is far more
> > > > flexible and accurate than 2.4, including features that lots of people
> > > > want, like separate source and object trees.
> > > 
> > > I don't see the masses, or, well, anybody on lkml, clamoring for this.
> > 
> > Clamour.
> 
> Clamour.

Clamour.

Being able to cp -a then build without full rebuild is good. Also make dep
takes  *long* and and bad things happen when you think it was not needed ;-).

									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

