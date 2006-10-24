Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWJXCYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWJXCYS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 22:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWJXCYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 22:24:18 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:34764 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S965045AbWJXCYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 22:24:17 -0400
Date: Mon, 23 Oct 2006 22:24:06 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.19-rc3
In-reply-to: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Message-id: <200610232224.06909.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 19:22, Linus Torvalds wrote:
>Ok,
> a few days late, because I'm a retard and didn't think of doing a
> release when I should have.

A couple of things noted in a dmesg report after booting it.

drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
-----
warning: process `date' used the removed sysctl system call
-----
warning: process `date' used the removed sysctl system call
-----
warning: process `quotaon' used the removed sysctl system call
------
warning: process `kudzu' used the removed sysctl system call
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00d0035600a886d8]
warning: process `kudzu' used the removed sysctl system call

The system seems to be ok so far.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
