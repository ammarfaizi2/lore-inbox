Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965284AbWGJW14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbWGJW14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWGJW1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:27:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:63884 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965281AbWGJW1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:27:53 -0400
Date: Tue, 11 Jul 2006 00:27:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: <Pine.LNX.4.64.0607101747160.2603@p34.internal.lan>
Message-ID: <Pine.LNX.4.61.0607110026030.5420@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
 <Pine.LNX.4.64.0607071037190.5153@p34.internal.lan> <17582.55703.209583.446356@cse.unsw.edu.au>
 <Pine.LNX.4.64.0607101747160.2603@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> md3 : active raid5 sdc1[7] sde1[6] sdd1[5] hdk1[2] hdi1[4] hde1[3] hdc1[1]
> hda1[0]
>      2344252416 blocks super 0.91 level 5, 512k chunk, algorithm 2 [8/8]
> [UUUUUUUU]
>      [>....................]  reshape =  0.2% (1099280/390708736)
> finish=1031.7min speed=6293K/sec
>
> It is working, thanks!
>
Hm, what's superblock 0.91? It is not mentioned in mdadm.8.


Jan Engelhardt
-- 
