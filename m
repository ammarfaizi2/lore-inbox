Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTKFTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTKFTdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:33:16 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:38819 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S263768AbTKFTdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:33:14 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Valdis.Kletnieks@vt.edu
Subject: Re: load 2.4.x binary only module on 2.6
Date: Thu, 6 Nov 2003 14:33:12 -0500
User-Agent: KMail/1.5.1
Cc: viro@parcelfarce.linux.theplanet.co.uk, Marcel Lanz <marcel.lanz@ds9.ch>,
       linux-kernel@vger.kernel.org
References: <20031106153004.GA30008@ds9.ch> <200311061243.19536.gene.heskett@verizon.net> <200311061922.hA6JMsHG003109@turing-police.cc.vt.edu>
In-Reply-To: <200311061922.hA6JMsHG003109@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061433.12555.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.62.77] at Thu, 6 Nov 2003 13:33:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 14:22, Valdis.Kletnieks@vt.edu wrote:
>On Thu, 06 Nov 2003 12:43:19 EST, Gene Heskett said:
>> It may be there, and I may have a copy of it, but it won't install
>> if I'm running 2.6.0-test9-mm2.
>
>Huh?  I'm running -test9-mm2 with the minion stuff as I'm typing
> this.

I've got minions 4496 here, so how did you make it work?  I had to 
revert to the kernel driver nv which doesn't do as much, but is 
easily 100000% more stable.

>Or are you talking about the general case if you have a wrapper for
>a 2.4 kernel?  If so, then yes, you'll need to do some programming
> to get the wrapper to do things the 2.6 way (which is what minion's
> patch basically does, it changes the NVidia 2.4 wrapper code to the
> 2.6 schemes).

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

