Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUHRAcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUHRAcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268532AbUHRAcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:32:15 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:51895 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S266854AbUHRAcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 20:32:11 -0400
Date: Wed, 18 Aug 2004 02:32:06 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Patrick McFarland <diablod3@gmail.com>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <0E7BAC91-F002-11D8-B893-000393ACC76E@mac.com>
Message-ID: <Pine.LNX.4.44.0408180220330.16972-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004, Kyle Moffett wrote:

> On Aug 16, 2004, at 09:32, Robert M. Stockmann wrote:
> > I was surprised to see a SuSE developer advise me to just do the
> > auto/auto thingy and _hope_ for the best, concerning burning a DVD-R.
> >
> > I would like to emphasise, its Open Source what we are discussing here!
> 
> Exactly! If you don't have anything useful to contribute WRT tracking 
> down
> a bug or fixing it, then you are expected to quit wasting the time of 
> those
> who _do_ have useful information/skills/etc. Jens Axboe has _repeatedly_
> asked you for your dmesg so he can determine if it's a bug or not, and 
> you
> have _repeatedly_ ignored his emails.  Either give us enough information
> to identify and fix the issue (if any), or shut up and let Jens Axboe 
> work with
> people who are willing to provide all necessary information.
> 
> Cheers,
> Kyle Moffett

I have had many disappointing try-outs with SuSE in the past, and everytime
when i think, this SuSE version is the one which will have my iron running
at warp 12, it fails again, for me that is. Dunno why that is.

The only thing i mentioned is, that i noticed that the compaq proliant 800,
2x PIII 500 had problems switching on DMA when booting the the default
installed kernel, 2.6.5 from SuSE 9.1 , after a vanilla default installation.

So i may turn the question around : Is SuSE's techsupport or development
dep. aware that there are issue's reported about DMA failing to switch on
when dealing with UDMA DVD writers? As to the machine, the compaq proliant
800 : its already sold, and sadly doesn't run the SuSE linux version.

Cheers,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

