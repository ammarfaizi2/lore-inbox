Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWCDOq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWCDOq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 09:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWCDOq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 09:46:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61969 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751796AbWCDOq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 09:46:26 -0500
Date: Sat, 4 Mar 2006 15:46:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: "S. Umar" <umar@compsci.cas.vanderbilt.edu>, linux-kernel@vger.kernel.org
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Message-ID: <20060304144625.GX9295@stusta.de>
References: <200602270900.13654.umar@compsci.cas.vanderbilt.edu> <s5hu0akssey.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hu0akssey.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 05:00:37PM +0100, Takashi Iwai wrote:
> At Mon, 27 Feb 2006 09:00:13 -0600,
> S. Umar wrote:
> > 
> > I can confirm this as well.
> > 
> > DEVICE:
> > Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
> > 
> > SYMPTOMS:
> > 
> >       1. No sound.
> >       2. kernel: azx_get_response timeout 
> >           messages in system log
> 
> It's a known interrupt problem.
> 
> The latest version on ALSA CVS has a workaround for this.
>...

Shouldn't this fix go into 2.6.16?

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

