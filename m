Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWACNOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWACNOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWACNOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:14:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8717 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751397AbWACNOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:14:08 -0500
Date: Tue, 3 Jan 2006 14:14:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060103131406.GC3831@stusta.de>
References: <20050726150837.GT3160@stusta.de> <1122393073.18884.29.camel@mindpipe> <42E65D50.3040808@pobox.com> <20050727182427.GH3160@stusta.de> <20050727203150.GF22686@tuxdriver.com> <42E7F1F9.2050105@pobox.com> <1122559208.32126.8.camel@localhost.localdomain> <Pine.LNX.4.61.0507281542420.8458@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507281542420.8458@tm8103.perex-int.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 03:43:49PM +0200, Jaroslav Kysela wrote:
> On Thu, 28 Jul 2005, Alan Cox wrote:
> 
> > On Mer, 2005-07-27 at 16:43 -0400, Jeff Garzik wrote:
> > > ISTR Alan saying there was some ALi hardware that either wasn't in ALSA, 
> > > or most likely didn't work in ALSA.  If Alan says I'm smoking crack, 
> > > then you all can ignore me :)
> > 
> > The only big thing I know that still needed OSS (and may still do so) is
> > the support for AC97 wired touchscreens and the like. Has that been
> > ported to ALSA ?
> 
> We're working on this issue right now.

What's the current status of this issue?

> 						Jaroslav

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

