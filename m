Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTKGAmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 19:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTKGAmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 19:42:43 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:49628 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262321AbTKGAmm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 19:42:42 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Valdis.Kletnieks@vt.edu
Subject: Re: load 2.4.x binary only module on 2.6
Date: Thu, 6 Nov 2003 19:42:39 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20031106153004.GA30008@ds9.ch> <200311061505.28953.gene.heskett@verizon.net> <200311062023.hA6KNnHG005148@turing-police.cc.vt.edu>
In-Reply-To: <200311062023.hA6KNnHG005148@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061942.39053.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.62.77] at Thu, 6 Nov 2003 18:42:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 15:23, Valdis.Kletnieks@vt.edu wrote:
>On Thu, 06 Nov 2003 15:05:28 EST, Gene Heskett said:
>> Very very easily done.  ctrl-alt-f2 to a shell.  It may, or may
>> not work.  crtl-alt-f7 back to X=locked up "tighter than Ft Knox"
>> computer, reset button or power button is all that works.
>
>Odd.. That works fine for me as well (I often do that to go look and
>see if exec-shield or ipfilters has tossed any odd messages).  I
> wonder if it's because I'm using the vesafb framebuffer driver over
> there and you're using something else? Or maybe the NVidia stuff
> happens to be stable for the GeForce 440Go in my Dell laptop, but
> is wonky for your card/box?

Dunno.  Card here is a gforce2-mx200, 32megs, your basic throwaway 
card.  X is 4.1.0, and I'm looking to see if I have the vesafb turned 
on, but I cannot find that as an option, and a grep of .config comes 
back empty.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

