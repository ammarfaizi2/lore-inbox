Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSK0Rh2>; Wed, 27 Nov 2002 12:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSK0Rh2>; Wed, 27 Nov 2002 12:37:28 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:28422 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264638AbSK0Rh1>; Wed, 27 Nov 2002 12:37:27 -0500
Date: Wed, 27 Nov 2002 17:44:43 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fbdev 2.5.49 BK fixes.
In-Reply-To: <20021127084425.GA488@pazke.ipt>
Message-ID: <Pine.LNX.4.44.0211271743320.30951-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> > 
> I see some harmless crap slipped into the patch again :))
> 
> Add these file into /home/jsimmons/dontdiff:
> 	vmlinux.lds.s
> 	gen_init_cpio
> 	initramfs_data.cpio.gz

Oops. Added.

> I'll test the patch this eveninig.

How did it work for you?

> Lets hope so.

It will :-)

> >     Several drivers have been ported but not all. NVIDIA is still broken 
> > but I will fix it tonight.
> 
> I can test the fix on my riva128.

Still broken. I didn't get a chance to port it last night :-(

