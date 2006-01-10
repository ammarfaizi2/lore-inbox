Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWAJUnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWAJUnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWAJUnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:43:01 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42880 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932605AbWAJUnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:43:00 -0500
Date: Tue, 10 Jan 2006 21:42:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
In-Reply-To: <17347.47882.735057.154898@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.61.0601102141570.16049@yvahk01.tjqt.qr>
References: <20060110125852.GA3389@suse.de> <17347.47882.735057.154898@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>2G/2G is not the only viable alternative. On my 1GB x86 box I'm
>using "lowmem1g" patches for both 2.4 and 2.6, which results in
>2.75G for user-space. I'm sure others have other preferences.
>Any standard option for this should either have several hard-coded
>alternatives, or should support arbitrary values (within reason).
>
>(See http://www.csd.uu.se/~mikpe/linux/patches/*/patch-i386-lowmem1g-*
>if you're interested.)

Hm, Con Kolivas also provided a lowmem1g patch in his set...



Jan Engelhardt
-- 
