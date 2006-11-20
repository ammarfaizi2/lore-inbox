Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966607AbWKTUCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966607AbWKTUCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966625AbWKTUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:02:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51211 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966607AbWKTUC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:02:28 -0500
Date: Mon, 20 Nov 2006 21:02:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: adaplas@pol.net, James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
Message-ID: <20061120200227.GZ31879@stusta.de>
References: <20061118000235.GV31879@stusta.de> <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de> <20061118195519.GZ31879@stusta.de> <Pine.LNX.4.58.0611201014280.24134@xplor.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0611201014280.24134@xplor.biophys.uni-duesseldorf.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 10:17:28AM +0100, Michael Schmitz wrote:
> > > > - FB_ATARI
> > >
> > > FB_ATARI has just been revived. Geert has a preliminary patch; I'll send
> > > the final one soonish.
> >
> > Thanks for this information.
> >
> > Are any of the following Atari options that are also on my
> > "BROKEN since at least 2.6.0" list also being revived?
> >
> > - HADES (arch/m68k/Kconfig)
> > - ATARI_ACSI (drivers/net/Kconfig)
> > - ATARI_BIONET (drivers/net/Kconfig)
> 
> These three I can try to 'revive' without actually being able to test
> them.
> 
> > - ATARI_PAMSNET (drivers/net/Kconfig)
> > - ATARI_SCSI (drivers/scsi/Kconfig)
> 
> These two (assuming PAMSNET is the VME ethercard) I can even test myself.
> So you can mark them 'being worked on'...

Thanks, I've removed them from my death row.

> 	Michael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

