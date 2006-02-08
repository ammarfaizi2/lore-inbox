Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWBHQxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWBHQxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWBHQxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:53:51 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:521 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1030374AbWBHQxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:53:50 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Wed, 8 Feb 2006 11:53:30 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060208165330.GB17534@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	peter.read@gmail.com, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org
References: <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EA1D26.nail40E11SL53@burner>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/06 05:32:38PM +0100, Joerg Schilling wrote:
> "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> 
> > On 02/08/06 02:27:41PM +0100, Joerg Schilling wrote:
> > > "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> > > 
> > > > All you've explained is that using SCSI ID for device names is the way
> > > > you want cdrecord to work, not why it's infinitely better than using real
> > > > device names like every other userland program on every OS in existance.
> > > 
> > > I did many times, but people don't seem to listen.
> >
> > But you've never answered the question as to why every other userland
> > program on every OS uses device names when cdrecord insists on using SCSI
> > IDs. Do you really think mount, fsck, tar, etc are broken because they let
> > the user use device names that they're accustomed to like /dev/c0t0d0s0? If
> > so, I look forward to the day that you try to patch OpenSolaris' userland
> > to work like cdrecord. 
> 
> You just verify that you don't listen...
 
Yes, I have been listening and I haven't seen you list one reason why
cdrecord absolutely has to use SCSI IDs when fsck can get away with using
/dev/blah just fine.

> I did answer this many times and I will not repeat it another time.
> 
> Note that you are of course wrong with your statement on other CD/DVD writing 
> software.

And of course you won't tell me exactly what I'm wrong about and/or point
me to some proof because then you might actually come off as helpful.

> What you like to see does not work at all on MS-WIN.

That's not my problem, but I would assume that Windows users would also
rather use a meaningful name like dev=D: instead of some random SCSI ID.

Jim.
