Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTCBXuk>; Sun, 2 Mar 2003 18:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTCBXuk>; Sun, 2 Mar 2003 18:50:40 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7684 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264688AbTCBXuj>;
	Sun, 2 Mar 2003 18:50:39 -0500
Date: Mon, 3 Mar 2003 00:53:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ben Collins <bcollins@debian.org>
Cc: andrea@e-mind.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed BitKeeper clone
Message-ID: <20030302235318.GB319@elf.ucw.cz>
References: <20030226200208.GA392@elf.ucw.cz> <20030302050420.GA22169@phunnypharm.org> <20030302051010.GB22169@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030302051010.GB22169@phunnypharm.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I've created little project for read-only (for now ;-) bitkeeper
> > > clone. It is available at www.sf.net/projects/bitbucket (no tar balls,
> > > just get it fresh from CVS).
> > 
> > In case it may be of some help, here's a script that is the result of my
> > own reverse engineering of the bitkeeper SCCS files. It can output a
> > diff, almost exactly the same as BitKeeper's gnupatch output from a
> > BitKeeper repo.
> 
> Might aswell supply my hacked sccsdiff script aswell.

There's a problem with this: it changes CSSC, and its GNU (read: needs
copyright assignment to apply changes). I can't really push your
changes to CSSC :-(. [What I can do is add .diff file into
bitbucket...]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
