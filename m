Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTKFUFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTKFUFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:05:38 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:25340 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S263832AbTKFUFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:05:31 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Valdis.Kletnieks@vt.edu
Subject: Re: load 2.4.x binary only module on 2.6
Date: Thu, 6 Nov 2003 15:05:28 -0500
User-Agent: KMail/1.5.1
Cc: viro@parcelfarce.linux.theplanet.co.uk, Marcel Lanz <marcel.lanz@ds9.ch>,
       linux-kernel@vger.kernel.org
References: <20031106153004.GA30008@ds9.ch> <200311061433.12555.gene.heskett@verizon.net> <200311061952.hA6Jq9HG004043@turing-police.cc.vt.edu>
In-Reply-To: <200311061952.hA6Jq9HG004043@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061505.28953.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.62.77] at Thu, 6 Nov 2003 14:05:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 14:52, Valdis.Kletnieks@vt.edu wrote:
>On Thu, 06 Nov 2003 14:33:12 EST, Gene Heskett said:
>> I've got minions 4496 here, so how did you make it work?  I had to
>> revert to the kernel driver nv which doesn't do as much, but is
>> easily 100000% more stable.
>
>Got NVidia's tarball, did the --extract-only thing, applied
>the Minion patch, 'cp Makefile.kbuild Makefile', reboot to the
>-mm2 kernel, 'cd src/NVdia<mumble>/usr/src/nv && make'.
>
>Actually, I've just had to do the 'make' for the last umpteen kernel
>revs - the Makefile dates back to Aug 4, and Sep 5 I had to apply a
>2-line fix to nv-linux.h.
>
>Not sure if the nv driver could be more stable - the last time I was
>able to tickle the NVidia code into crashing either XFree86 or the
> kernel was back in the 2.5.6* time frame.

Very very easily done.  ctrl-alt-f2 to a shell.  It may, or may not 
work.  crtl-alt-f7 back to X=locked up "tighter than Ft Knox" 
computer, reset button or power button is all that works.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

