Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVCEQyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVCEQyt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCEQtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:49:43 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:32233 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S263123AbVCEQo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:44:59 -0500
Date: Sat, 05 Mar 2005 11:44:58 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: diff command line?
In-reply-to: <20050305161822.H3282@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503051144.58635.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503051048.00682.gene.heskett@verizon.net>
 <20050305161822.H3282@flint.arm.linux.org.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 11:18, Russell King wrote:
>On Sat, Mar 05, 2005 at 10:48:00AM -0500, Gene Heskett wrote:
>> What are the options normally used to generate a diff for public
>> consumption on this list?
>
>diff -urpN orig new
>
>where "orig" and "new" both contain the top level "linux" directory,
>so the resulting patch can be applied with patch -p1.

Which means the patch I just submitted is wrong, I made it while cd'd 
to the 2.6.11 tree.  Damn.  I'll remake & resubmit.

Thanks

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
