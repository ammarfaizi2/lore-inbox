Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTKJWYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTKJWYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:24:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18948 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264137AbTKJWYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:24:52 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: 10 Nov 2003 22:14:19 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bop2jr$772$1@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1031106172846.16450A-100000@gatekeeper.tmr.com> <200311061951.27468.gene.heskett@verizon.net>
X-Trace: gatekeeper.tmr.com 1068502459 7394 192.168.12.62 (10 Nov 2003 22:14:19 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200311061951.27468.gene.heskett@verizon.net>,
Gene Heskett  <gene.heskett@verizon.net> wrote:
| On Thursday 06 November 2003 17:36, Bill Davidsen wrote:

| >Are you saying that a 12x burn using a 2.4 kernel and ide-scsi
| > doesn't take the same time? Because I see ~1.7MB/s if I use
| > speed=12 with ide-scsi, and that's as expected (1x = 44100*4/1024
| > kB/s). Haven't got a 2.6 system with a burner here, but I do at my
| > other site.
| 
| Mmm, thats pretty close, Bill.  Maybe its something I just noted the 
| last time I tried to burn a disk under ide-scsi, but I caught it 
| turning the write speed down to 8x from the 12x setting.  It may have 
| been doing that previously without advising me or??  The old times 
| were usually just short of 10 minutes.

Thanks, I hope to try this Friday, I have a system I can update to 2.6
and try it. I'll try the bttv stuff again as well. I have noticed that
the audio burns in 2.4, which don't use DMA, seem to take a lot of CPU,
but not that they run slower. More to come.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
