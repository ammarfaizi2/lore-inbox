Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945905AbWBCTSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945905AbWBCTSm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945900AbWBCTSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:18:42 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:20999 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1945908AbWBCTSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:18:40 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Fri, 3 Feb 2006 14:18:22 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       cdwrite@other.debian.org, acahalan@gmail.com
Subject: Re: [cdrtools PATCH (GPL)] Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203191821.GD11241@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
	cdwrite@other.debian.org, acahalan@gmail.com
References: <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203182049.GB11083@merlin.emma.line.org> <43E3A19E.nail6A511N92B@burner> <20060203184240.GC11241@voodoo> <43E3AA95.nail6AV21A253@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43E3AA95.nail6AV21A253@burner>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/06 08:10:13PM +0100, Joerg Schilling wrote:
> "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> 
> > On 02/03/06 07:31:58PM +0100, Joerg Schilling wrote:
> > > Matthias Andree <matthias.andree@gmx.de> wrote:
> > > 
> > > > So patches to the rescue -- please review the patch below (for 2.01.01a05).
> > > > Note that GPL 2a and 2c apply, so you cannot merge a modified version of
> > > > my patch without adding a tag that you goofed my fixes.
> > > 
> > > OK, I did not look at it and I never will!
> > > 
> > > Jörg
> >
> > This is an excellent example to verify how bad cdrecord developent
> > is done.....
> 
> Well,
> 
> cdrecord is done as good as possible. 

The fact that you seem to sling mud at everyone that doesn't agree
with you makes that seem questionable.

> Note that if peope send a patch together with personal infringements or 
> untrue claims, the best I can do is to ignore alltogether.
> 
> I did spend a lot of time with a fruitful discussion with Matthias.
> Then Matthias started this thread.... It now seems like Matthias 
> does not like to be serious anymore.

It's hard to have a serious discussion with you because you just keep
parotting the same things and pointing fingers over and over.

> I am of course interested to make cdrecord better, but for the price
> of spending an ridiculously amount of time ob LKML.
> 
> Jörg
> 

And you never did answer my question about why cdrecord is the only app on any
OS to use devicename:scsibus,target,lun to specify the target device. Every
other tool out there, e.g. mount, fsck, tar, etc, all use the device name
exported by the OS, e.g. /dev/c0t0s0d0, /dev/hda1, /dev/nst0, etc, so why
is it necessary for cdrecord to be different?

Jim.
