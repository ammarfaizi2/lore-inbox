Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVLGDoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVLGDoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVLGDoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:44:17 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:33531 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932247AbVLGDoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:44:16 -0500
Date: Tue, 06 Dec 2005 22:44:14 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ntp problems
In-reply-to: <1133839229.7605.63.camel@cog.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Message-id: <200512062244.14921.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512050031.39438.gene.heskett@verizon.net>
 <200512052107.24427.gene.heskett@verizon.net>
 <1133839229.7605.63.camel@cog.beaverton.ibm.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 22:20, john stultz wrote:

[...]

>Hmmm. Indeed the nforce2 has had a number of problems, but I'm not sure
>why it would have changed recently. Can you bound at all the kernel
>versions where it worked and where it broke? Additionally, do be sure
>you have the most recent BIOS, I've seen a number of nforce2 issues be
>resolved with a BIOS update.

And, while I had a heck of a time doing the bios upgrade, it did work, 
acpi is now enabled, and ntpd is working 'nominally'.

Many thanks for the kick in the pants to go do that, John.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
