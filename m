Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVGYX2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVGYX2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 19:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVGYX2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 19:28:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61452 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261482AbVGYX0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 19:26:15 -0400
Date: Tue, 26 Jul 2005 01:26:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Haninger <ahaning@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: BUG: Yamaha OPL3SA2 does not work with ALSA on 2.6 kernels.
Message-ID: <20050725232604.GH3160@stusta.de>
References: <105c793f05072507315cfd1878@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105c793f05072507315cfd1878@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 10:31:37AM -0400, Andrew Haninger wrote:

> Hello.

Hi Andrew,

> I have a 5 year old Gateway Solo 2500 that is currently running Linux
> 2.6.12.2. If I install ALSA and try to have alsaconf bruteforce-detect
> the OPL3SA2 sound card, it will say that it has detected it, but
> loading the modules will fail. If I install Linux 2.4 and
> recompile/rerun alsaconf, the detection works fine and the card works.
> Copying the configuration detected under 2.4 into a modprobe.conf on
> 2.6 allows me to use the card in 2.6 with occasional crashes (which
> might be due to suspend2).

the ALSA people might be able to help you (Cc'ed).

> Searching around the net, I find many other people having trouble with
> these cards and the ALSA-Linux2.6 combination. On one page, someone
> suggested that there were changes made between 2.4 and 2.6 to the ISA
> code that broke ALSA's detection routines.
> 
> I'm not sure what information might be needed in order to get this
> card working well once and for all, but if someone will let me know,
> I'd be happy to provide.

Does the OSS driver work in 2.6?

> Thanks.
> 
> -Andy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

