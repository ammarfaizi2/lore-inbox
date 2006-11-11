Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753757AbWKKSTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbWKKSTf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbWKKSTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:19:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40721 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753757AbWKKSTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:19:34 -0500
Date: Sat, 11 Nov 2006 19:19:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM in 2.6.19-rc*
Message-ID: <20061111181937.GC25057@stusta.de>
References: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 04:40:17PM +0000, Christian Kujau wrote:
> Hello,
> 
> a few days ago I upgraded my desktop machine (x86_64) to ubuntu/edgy 
> thus completely changing the userland. Since I'm using kernel.org 
> kernels I upgraded to a current kernel as well (2.6.19-rc4-git from Nov 
> 4 and 2.6.19-rc4-mm2). Now, while working under X11, probably reading 
> email, all of a sudden the machine was not responsible any more and the 
> disk was spinning like wild. The desktop applet showed all swap being 
> used up then the display froze too and ~5 min later the machine came 
> back with the gnome-login screen: it had not rebooted but ran OOM and 
> several apps got killed.
>...

Can you test whether an older kernel (preferably the one that worked 
before) shows the same problem?

This way you might know whether it's a kernel problem or a distribution 
problem.

> Thanks for your thoughts,
> Christian.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

