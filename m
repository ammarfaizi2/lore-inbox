Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTAOAV4>; Tue, 14 Jan 2003 19:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTAOAV4>; Tue, 14 Jan 2003 19:21:56 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:58640 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265517AbTAOAVz>; Tue, 14 Jan 2003 19:21:55 -0500
Date: Wed, 15 Jan 2003 00:30:45 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jens Axboe <axboe@suse.de>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK fbdev updates]
In-Reply-To: <20030112150744.GH14017@suse.de>
Message-ID: <Pine.LNX.4.44.0301130226560.18576-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Linus, please do a
> 
> James,
> 
> 2.5 still doesn't work on my vaio (I think I told you about this 3-4
> months ago) with the neofb. It just crashes with a black screen. If you
> don't have any clues what the problem is, I can hook the machine up to a
> serial console and see if anything interesting pops up. Using vesafb
> does make it boot, however the screen stays pitch black until X loads...

VESA doesn't work either. Can you check to see if you have framebuffer 
console enabled. Yes I'm curious to see why your neofb doesn't work.


