Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264783AbSJ3TDM>; Wed, 30 Oct 2002 14:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264784AbSJ3TDM>; Wed, 30 Oct 2002 14:03:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60818 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264783AbSJ3TDK>;
	Wed, 30 Oct 2002 14:03:10 -0500
Date: Wed, 30 Oct 2002 11:13:20 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Ian Soboroff <ian.soboroff@nist.gov>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: post-halloween 0.2
In-Reply-To: <9cfwunzsqbc.fsf@rogue.ncsl.nist.gov>
Message-ID: <Pine.LNX.4.44.0210301111130.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Oct 2002, Ian Soboroff wrote:

> Greg KH <greg@kroah.com> writes:
> 
> > On Wed, Oct 30, 2002 at 01:47:19PM -0500, Ian Soboroff wrote:
> > > Dave Jones <davej@codemonkey.org.uk> writes:
> > > 
> > > > driverfs
> > > > ~~~~~~~~
> > > > [...]
> > > > *NB*, at some point the name of this filesystem will be changing to sysfs.
> > > > See Documentation/filesystems/sysfs.txt for more info.
> > > 
> > > Probably have to wait until we push the rock up the hill again.
> > 
> > What do you mean?  This should happen in the next few kernel releases.
> 
> sysfs == Sisyphus, a character of Greek mythology doomed by the gods
> to roll a boulder up a hill for all time.  When he gets to the top, it
> rolls back down.

sysfs != Sisyphus. They are coincidental hominems. 

> Kind of like fixing /proc.  <ducks>

Recall also that (Feature Freeze != Code Freeze). There will be a lot of 
cleanup and conversion happening the next few months, from old school 
driver models to the new driver models, and the population of a sane sysfs 
layout. 

driverfs will hopefully die today. Stay tuned..

	-pat

