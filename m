Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311553AbSCNGx0>; Thu, 14 Mar 2002 01:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311554AbSCNGxR>; Thu, 14 Mar 2002 01:53:17 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:52492 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311553AbSCNGxC>; Thu, 14 Mar 2002 01:53:02 -0500
Date: Thu, 14 Mar 2002 07:52:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Martin Dalecki <martin@dalecki.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PIIX rewrite patch, pre-final
Message-ID: <20020314075258.A31815@ucw.cz>
In-Reply-To: <20020314001449.A31068@ucw.cz> <Pine.LNX.4.40.0203132004310.7822-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0203132004310.7822-100000@coredump.sh0n.net>; from spstarr@sh0n.net on Wed, Mar 13, 2002 at 08:04:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 08:04:38PM -0500, Shawn Starr wrote:

> This will benifit PIIX3 chipsets? :)

It should.

> 
> On Thu, 14 Mar 2002, Vojtech Pavlik wrote:
> 
> > Hi!
> >
> > This is a rewrite of the PIIX IDE timing driver. It should give slightly
> > better performance (+4% was measured), and also replaces the slc90c66
> > Efar Victory66 driver, because the Victory66 is mostly a PIIX clone.
> >
> > It has been tested on PIIX4 only. Please anyone with a PIIX or ICH chip,
> > and if anyone has the Victory66 one even moreso, test this if you can.
> >
> > The patch is against 2.5.6 + the patches I sent earlier, for a complete
> > patch against clean 2.5.6 see
> >
> > http://twilight.ucw.cz/ide-via-amd-piix-timing-8-pre-final.diff
> >
> > Killed code good code. :)
> >
> > --
> > Vojtech Pavlik
> > SuSE Labs
> >

-- 
Vojtech Pavlik
SuSE Labs
