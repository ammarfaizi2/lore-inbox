Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289824AbSBKTU3>; Mon, 11 Feb 2002 14:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290211AbSBKTUU>; Mon, 11 Feb 2002 14:20:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55046 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289824AbSBKTT6>; Mon, 11 Feb 2002 14:19:58 -0500
Date: Mon, 11 Feb 2002 14:19:00 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Steve Snyder <steves@formation.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Why won't my HD do DMA I/O?
In-Reply-To: <KMEBIOGPEGOACPDOHPEEMEAMCAAA.steves@formation.com>
Message-ID: <Pine.LNX.3.96.1020211141639.642D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Steve Snyder wrote:

> I should have noted this in my original post but, yes, I have enabled DMA in
> the kernel:
> 
> # grep DMA /usr/src/linux-2.4.17/.config | grep -v '#'
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_AUTO=y
> 
> Thanks for the response.

Since I'm guessing at things which are unlikely, and I believe you said
"only one drive" has this, did you check the cable type, seating, and
condition? Putting in new hardware is such fun, I've found many inobvious
ways to do it almost perfectly ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

