Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbWBGNrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbWBGNrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbWBGNrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:47:08 -0500
Received: from mail.gmx.de ([213.165.64.21]:2184 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965081AbWBGNrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:47:07 -0500
X-Authenticated: #428038
Date: Tue, 7 Feb 2006 14:47:02 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060207134702.GA8071@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <20060123105634.GA17439@merlin.emma.line.org> <200602021717.08100.luke@dashjr.org> <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr> <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E89B56.nailA792EWNLG@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-07:

> "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> 
> > You're not alone, I'm still waiting for an answer as to why cdrecord is
> > the only userland app on any OS to use his SCSI ID naming convention
> > and yet his is the correct way. I've asked twice and been blatantly
> > ignored both times.
> 
> Well, while I did explain this many times (*), I am still waiting 
> for an explanation why Linux tries to deviate from nearly all other OS.

You documented differences between FreeBSD that require you to jump
hoops and Solaris yourself, and still your software supports FreeBSD?

> *) in case you like are on amnesia: without the mapping in libscg,
> cdrecord could not be used reliably on Linux. And yes, I _do_ care
> about people who run Linux-2.4 or older!

What about dev=/dev/sg1 (via ide-scsi) doesn't work on Linux 2.4, except
DMA for 2352 byte blocks?

> It seems that we should stop this discussion.

There is no obligation for you to respond. But don't expect to be taken
seriously or listened to if you fleet the discussion as soon as it has
become uncomfortable for you.

> As long as the peeople who answer here are onlookers without the 
> needed skills, it seems to be a waste of time.

Yes indeed. You're asked the same things a dozen times and still ignore
those questions rather than giving the answers that might someone
investigate the issue.

-- 
Matthias Andree
