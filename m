Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266500AbUG0SDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266500AbUG0SDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUG0SDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:03:08 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:11768 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S266500AbUG0SDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:03:01 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Tue, 27 Jul 2004 14:02:59 -0400
User-Agent: KMail/1.6
References: <200407271233.04205.gene.heskett@verizon.net> <200407271343.43583.gene.heskett@verizon.net> <20040727103256.2691d6f9.rddunlap@osdl.org>
In-Reply-To: <20040727103256.2691d6f9.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271402.59846.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.53.180] at Tue, 27 Jul 2004 13:03:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 13:32, Randy.Dunlap wrote:
[...]
Gene Heskett wrote:
>| I take it that I should apply these to a 2.6.7 tarballs tree in
>| this order:
>| 1. 2.6.8-rc1
>|
>>>>> 2.6.8-rc2 <<<<<
2.6.8-rc2?  These patches I got will need to be reverted then?
>|
>| 2. each of these 'rc2-bk' patches by the day and then run each for
>| a couple days, or should I start in the middle, say the 3rd one
>| and work forward or backwards from there depending on the results?
>
>I'd suggest beginning with -bk3 and doing a binary search.

Ok, as soon as the kde build exits (and it will, bet the whole farm on 
it)  I'll give it a try.

>| Your (and Viro's) call.  I'd imagine you would want to run this to
>| earth as quick as we can.
>|
>| Are these patches cumulative?  I presume they are as they grow by
>| the day.
>
>Sorry, I should have mentioned that.  Yes, they are cumulative.

Well, it was a pretty obvious conclusion :)

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
