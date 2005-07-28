Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVG1ORS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVG1ORS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVG1ORP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:17:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59140 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261460AbVG1OPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:15:23 -0400
Date: Thu, 28 Jul 2005 16:15:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, Takashi Iwai <tiwai@suse.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050728141521.GI3528@stusta.de>
References: <20050726150837.GT3160@stusta.de> <1122393073.18884.29.camel@mindpipe> <42E65D50.3040808@pobox.com> <20050727182427.GH3160@stusta.de> <20050727203150.GF22686@tuxdriver.com> <42E7F1F9.2050105@pobox.com> <1122559208.32126.8.camel@localhost.localdomain> <Pine.LNX.4.61.0507281542420.8458@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507281542420.8458@tm8103.perex-int.cz>
User-Agent: Mutt/1.5.9i
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

Does "right now" mean it will be done in a few days or a few months?

I'm asking because in the latter case I'll remove the driver from my 
current "scheduled for removal" list.

> 						Jaroslav

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

