Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTKPTBP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 14:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTKPTBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 14:01:15 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:25827 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S263130AbTKPTBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 14:01:14 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] 2.6.0-test9 - document elevator= parameter
Date: Sun, 16 Nov 2003 14:01:11 -0500
User-Agent: KMail/1.5.1
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
References: <200311160259.hAG2x4La006117@turing-police.cc.vt.edu> <200311161233.05347.gene.heskett@verizon.net> <200311161826.hAGIQELa030180@turing-police.cc.vt.edu>
In-Reply-To: <200311161826.hAGIQELa030180@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311161401.11089.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.12.17] at Sun, 16 Nov 2003 13:01:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 November 2003 13:26, Valdis.Kletnieks@vt.edu wrote:
>On Sun, 16 Nov 2003 12:33:05 EST, Gene Heskett said:
>> since I'm running a test9-mm3 kernel, where might i find a
>> discussion of this scheduler?
>
>Well, all the source is in drivers/block/cfq-iosched.c and here's
>Jens Axboe explaining it:
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=104495457606855&w=2

Thanks.  It almost sounds a little tongue in cheek, but then makes a 
lot of sense.  Just for giggles, I'll set up another entry in 
grub.conf that uses it & give it a try.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

