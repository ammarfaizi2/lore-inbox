Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWASVne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWASVne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161425AbWASVne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:43:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8967 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161122AbWASVnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:43:33 -0500
Date: Thu, 19 Jan 2006 22:43:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060119214332.GZ19398@stusta.de>
References: <20060119174600.GT19398@stusta.de> <9a8748490601191306q75b101b5g488aee398d420a00@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601191306q75b101b5g488aee398d420a00@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 10:06:47PM +0100, Jesper Juhl wrote:
> On 1/19/06, Adrian Bunk <bunk@stusta.de> wrote:
> [snip]
> > My proposed timeline is:
> [snip]
> > - after the release of 2.6.17 (and before 2.6.18):
> >   remove the subset of drivers marked at OBSOLETE_OSS_DRIVER without
> >   known regressions in the ALSA drivers for the same hardware
> 
> May I suggest you also update the "When" part of this entry in
> Documentation/feature-removal-schedule.txt :
> 
> What:   drivers depending on OBSOLETE_OSS_DRIVER
> When:   January 2006
> Why:    OSS drivers with ALSA replacements
> Who:    Adrian Bunk <bunk@stusta.de>

Sure. This will be sent as part of my patch to update the 
OBSOLETE_OSS_DRIVER dependencies.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

