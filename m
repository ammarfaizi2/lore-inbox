Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131093AbRBLGim>; Mon, 12 Feb 2001 01:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131180AbRBLGic>; Mon, 12 Feb 2001 01:38:32 -0500
Received: from lindy.SoftHome.net ([204.144.232.9]:22803 "HELO
	lindy.softhome.net") by vger.kernel.org with SMTP
	id <S131093AbRBLGiV>; Mon, 12 Feb 2001 01:38:21 -0500
Message-ID: <20010212070503.31764.qmail@lindy.softhome.net>
To: linux-kernel@vger.kernel.org
Subject: sysinfo.sharedram not accounted for on i386 ?
Organization: SoftHome
X-URL: http://www.SoftHome.net/
Date: Mon, 12 Feb 2001 00:05:03 -0700
From: Brian Grossman <brian@SoftHome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On i386, sysinfo.sharedram is not accounted for, leading /proc/meminfo to
always report MemShared as 0.  Is this the intended behavior?

Brian
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
