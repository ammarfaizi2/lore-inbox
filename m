Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275444AbTHJBHo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 21:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275446AbTHJBHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 21:07:44 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:52956 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP id S275444AbTHJBHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 21:07:43 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: "Matthew Mullins" <mokomull@cox-internet.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 Makefile
Date: Sat, 9 Aug 2003 21:07:42 -0400
User-Agent: KMail/1.5.1
References: <003501c35ed2$a6ff5400$71f14c42@coxinternet.com>
In-Reply-To: <003501c35ed2$a6ff5400$71f14c42@coxinternet.com>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308092107.42268.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop015.verizon.net from [151.205.63.55] at Sat, 9 Aug 2003 20:07:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 August 2003 20:02, Matthew Mullins wrote:
>The makefile bundled with 2.6.0-test3 won't install the modules
> correctly. 'make modules' compiles the modules to *.o, but 'make
> modules_install' expects to find them as *.ko.
>
>If I could find some documentation on the makefiles (or makefiles in
>general), I'd be able to submit a patch.
>
>-MrM

I believe you may have something a bit odd there, its working here 
with test3.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

