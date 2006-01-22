Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWAVTZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWAVTZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWAVTZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:25:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55312 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751027AbWAVTZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:25:01 -0500
Date: Sun, 22 Jan 2006 20:25:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <20060122192501.GI10003@stusta.de>
References: <43D3295E.8040702@comcast.net> <Pine.LNX.4.61.0601220945160.5126@yvahk01.tjqt.qr> <20060122190533.GH10003@stusta.de> <1137956898.3328.38.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137956898.3328.38.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 08:08:17PM +0100, Arjan van de Ven wrote:
> On Sun, 2006-01-22 at 20:05 +0100, Adrian Bunk wrote:
> > On Sun, Jan 22, 2006 at 09:51:10AM +0100, Jan Engelhardt wrote:
> > >...
> > >  - I would not use a journalling filesystem at all on media that degrades
> > >    faster as harddisks (flash drives, CD-RWs/DVD-RWs/RAMs).
> > >    There are specially-crafted filesystems for that, mostly jffs and udf.
> > >...
> > 
> > [ ] you know what the "j" in "jffs" stands for
> 
> it stands for "logging" since jffs2 at least is NOT a journalling
> filesystem.... but a logging one. I assume jffs is too.

Ah, sorry.

It seems I confused this with Reiser4 and it's wandering logs.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

