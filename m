Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbUK2RFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbUK2RFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 12:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbUK2RFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 12:05:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26118 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261177AbUK2RFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 12:05:01 -0500
Date: Mon, 29 Nov 2004 18:04:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: hugang@soulinfo.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: ppcfix.diff
Message-ID: <20041129170458.GA9908@stusta.de>
References: <20041129154041.GB4616@hugang.soulinfo.com> <Pine.LNX.4.53.0411291742450.30846@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411291742450.30846@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 05:42:59PM +0100, Jan Engelhardt wrote:
> >Please apply this patch, to fix compile error in debian woody.
> >$gcc -v
> >Reading specs from /usr/lib/gcc-lib/powerpc-linux/2.95.4/specs
> >gcc version 2.95.4 20011002 (Debian prerelease)
> 
> Is 2.95.*4* supported, after all?

2.95.4 is the version the post-2.95.3 snapshot of the gcc 2.95 
identifies itself. There was no official 2.95.4 and I don't know what is 
supported on ppc, but at least on i386, it is supported.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

