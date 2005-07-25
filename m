Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVGYVxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVGYVxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVGYVxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:53:41 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:6594 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261432AbVGYVxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:53:40 -0400
Date: Mon, 25 Jul 2005 17:53:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Question re the dot releases such as 2.6.12.3
In-reply-to: <42E51593.7070902@didntduck.org>
To: linux-kernel@vger.kernel.org
Message-id: <200507251753.38217.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200507251020.08894.gene.heskett@verizon.net>
 <42E51593.7070902@didntduck.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 July 2005 12:38, Brian Gerst wrote:
>Gene Heskett wrote:
>> Greetings;
>>
>> I just built what I thought was 2.6.12.3, but my script got a
>> tummy ache because I didn't check the Makefile's EXTRA_VERSION,
>> which was set to .2 in the .2 patch.  Now my 2.6.12 modules will
>> need a refresh build. :(
>>
>> So whats the proper patching sequence to build a 2.6.12.3?
>
>The dot-release patches are not incremental.  You apply each one to
> the base 2.6.12 tree.
>
Thats what I thought, and I blew that tree away & rebuilt it again 
using the same script, and it worked.  Go figure...

Thanks Brian.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
