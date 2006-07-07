Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWGGWje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWGGWje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWGGWje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:39:34 -0400
Received: from lucidpixels.com ([66.45.37.187]:61071 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932352AbWGGWjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:39:33 -0400
Date: Fri, 7 Jul 2006 18:39:32 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: <17582.57931.816012.142421@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0607071838480.8499@p34.internal.lan>
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
 <Pine.LNX.4.64.0607071037190.5153@p34.internal.lan> <17582.55703.209583.446356@cse.unsw.edu.au>
 <Pine.LNX.4.64.0607071814510.8499@p34.internal.lan> <17582.57549.204471.855655@cse.unsw.edu.au>
 <Pine.LNX.4.64.0607071832200.8499@p34.internal.lan> <17582.57931.816012.142421@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jul 2006, Neil Brown wrote:

> On Friday July 7, jpiszcz@lucidpixels.com wrote:
>>
>> I guess one has to wait until the reshape is complete before growing the
>> filesystem..?
>
> Yes.  The extra space isn't available until the reshape has completed
> (if it was available earlier, the reshape wouldn't be necessary....)
>
> NeilBrown
>

Just wanted to confirm, thanks for all the help, I look forward to the new 
revision of mdadm :)  In the mean time, after I get another drive I will 
try your work around, but so far it looks good, thanks.!

Justin.

