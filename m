Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTLBClK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 21:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbTLBClK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 21:41:10 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:28582 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S263885AbTLBClF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 21:41:05 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: amanda vs 2.6
Date: Mon, 1 Dec 2003 21:41:01 -0500
User-Agent: KMail/1.5.1
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <piggin@cyberone.com.au>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311291214.33130.gene.heskett@verizon.net> <20031201184357.GI1566@mis-mike-wstn.matchmail.com>
In-Reply-To: <20031201184357.GI1566@mis-mike-wstn.matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312012141.01223.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.54.127] at Mon, 1 Dec 2003 20:41:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 December 2003 13:43, Mike Fedyk wrote:
>On Sat, Nov 29, 2003 at 12:14:33PM -0500, Gene Heskett wrote:
>> Another data point about this, still unsolved problem:
>>
>> The number of times I can do an 'su amanda' then exit, and redo
>> the it seem to be somewhat random,  One test I managed to get to
>> the 4th su
>
>Did you try to 'strace su amanda'?

Yes, about 25-30 times just now, without any failures... WTH ??

>What version of glibc are you running?

>2.3.2-4

>What distro and version?

Formerly rh8.0 with almost all updates, eg if its still an rpm, I let 
update do it.  Hand built stuffs like cups and sane are newer than 
8.0, as is the currently working kde-3.1.1a.  Obviously I don't let 
up2date anywhere near that stuff.

On 'verify'ing the glibc install, gnorpm complains about 
/etc/localtime's link status.  Other than that, its clean ANAICT.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

