Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289982AbSBKSVS>; Mon, 11 Feb 2002 13:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289989AbSBKSVJ>; Mon, 11 Feb 2002 13:21:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50182 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290012AbSBKSU6>; Mon, 11 Feb 2002 13:20:58 -0500
Date: Mon, 11 Feb 2002 13:20:02 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Steve Snyder <steves@formation.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why won't my HD do DMA I/O?
In-Reply-To: <KMEBIOGPEGOACPDOHPEEKEAKCAAA.steves@formation.com>
Message-ID: <Pine.LNX.3.96.1020211131841.32755E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Steve Snyder wrote:

> I've got a system on which the hard disk cannot be set to use DMA.  When I
> attempt to enable DMA ("hdparm -d1 /dev/hda") on this drive, there is a long
> time-out period, after which displaying the settings shows that DMA is still
> not set.

You did build this kernel with DMA support in the kernel, right? For your
chipset? Vendor kernels have been known to err on the side of safty.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

