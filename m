Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVJ3NvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVJ3NvW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 08:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVJ3NvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 08:51:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50701 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750874AbVJ3NvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 08:51:22 -0500
Date: Sun, 30 Oct 2005 14:51:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20051030135121.GY4180@stusta.de>
References: <20051030105118.GW4180@stusta.de> <200510300841.06485.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510300841.06485.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 09:41:06AM -0400, Gene Heskett wrote:
> On Sunday 30 October 2005 05:51, Adrian Bunk wrote:
> >This patch schedules obsolete OSS drivers (with ALSA drivers that
> > support the same hardware) for removal.
> >
> >Scheduling the via82cxxx driver for removal was ACK'ed by Jeff Garzik.
> >
> Isn't this a bit premature?  There are quite a few old mobo's with this
> chipset still in use, like my firewall box.
>...

Sounds like a deja vu:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0507.3/0527.html
  http://www.ussg.iu.edu/hypermail/linux/kernel/0507.3/0555.html
  http://www.ussg.iu.edu/hypermail/linux/kernel/0507.3/0717.html

;-)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

