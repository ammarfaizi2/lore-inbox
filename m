Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268139AbTCCApC>; Sun, 2 Mar 2003 19:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268150AbTCCApC>; Sun, 2 Mar 2003 19:45:02 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:17159 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S268139AbTCCApB>; Sun, 2 Mar 2003 19:45:01 -0500
Date: Sun, 2 Mar 2003 19:53:59 -0500
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: andrea@e-mind.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed BitKeeper clone
Message-ID: <20030303005359.GG458@phunnypharm.org>
References: <20030226200208.GA392@elf.ucw.cz> <20030302050420.GA22169@phunnypharm.org> <20030302051010.GB22169@phunnypharm.org> <20030302235318.GB319@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030302235318.GB319@elf.ucw.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 12:53:18AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > I've created little project for read-only (for now ;-) bitkeeper
> > > > clone. It is available at www.sf.net/projects/bitbucket (no tar balls,
> > > > just get it fresh from CVS).
> > > 
> > > In case it may be of some help, here's a script that is the result of my
> > > own reverse engineering of the bitkeeper SCCS files. It can output a
> > > diff, almost exactly the same as BitKeeper's gnupatch output from a
> > > BitKeeper repo.
> > 
> > Might aswell supply my hacked sccsdiff script aswell.
> 
> There's a problem with this: it changes CSSC, and its GNU (read: needs
> copyright assignment to apply changes). I can't really push your
> changes to CSSC :-(. [What I can do is add .diff file into
> bitbucket...]

I'm putting my changes to CSSC into the public domain. The FSF can do
whatever it wants.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
