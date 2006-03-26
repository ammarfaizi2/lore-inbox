Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWCZKGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWCZKGp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 05:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWCZKGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 05:06:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24851 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750786AbWCZKGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 05:06:44 -0500
Date: Sun, 26 Mar 2006 12:06:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linda Walsh <lkml@tlinx.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Save 320K on production machines?
Message-ID: <20060326100639.GE4053@stusta.de>
References: <4426515B.5040307@tlinx.org> <Pine.LNX.4.61.0603261122410.22145@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603261122410.22145@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 11:24:15AM +0200, Jan Engelhardt wrote:
>...
> > ** primarily "funit-at-a-time", though -fweb &
> > -frename-registers may add a bit (GCC 3.3.5 as
> > patched by SuSE; Maybe extra optimizations could
> > be a "CONFIG" option much like regparms is now?
> 
> IIRC, -funit-at-a-time with gcc3 made compiled code go bloat.

That's wrong, the compiled code is smaller.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

