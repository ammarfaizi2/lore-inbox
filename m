Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWDAJVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWDAJVi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 04:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWDAJVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 04:21:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58385 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750755AbWDAJVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 04:21:38 -0500
Date: Sat, 1 Apr 2006 11:21:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Christian Trefzer <ctrefzer@gmx.de>, Takashi Iwai <tiwai@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: snd-nm256: hard lockup on every second module load after powerup
Message-ID: <20060401092136.GD28310@stusta.de>
References: <20060326054542.GA11961@hermes.uziel.local> <s5hveu0chvy.wl%tiwai@suse.de> <1143500400.1792.314.camel@mindpipe> <20060329144303.GA24146@hermes.uziel.local> <20060331211240.GD22677@stusta.de> <1143841995.27146.25.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143841995.27146.25.camel@mindpipe>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 04:53:13PM -0500, Lee Revell wrote:
> On Fri, 2006-03-31 at 23:12 +0200, Adrian Bunk wrote:
> > > Actually, the changes in Linus' current git have fixed the hang for
> > me.
> > > Good job - thanks a lot, guys!
> > > 
> > > Kind regards,
> > > Chris
> > 
> > Takashi, would it be possible getting the fixes for this hard lookup 
> > into 2.6.16.2?
> > 
> 
> Is a 225 line patch to fix a driver that's never worked appropriate for
> -stable?

If it was only "not working" it wasn't that bad, but "hard lockup" is 
really bad.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

