Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVGRP4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVGRP4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 11:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVGRP4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 11:56:44 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:44445 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261790AbVGRPz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 11:55:56 -0400
Date: Mon, 18 Jul 2005 12:44:40 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] I-pipe 2.6.12-v0.9-02
In-reply-to: <42DBB18E.7090707@xenomai.org>
To: linux-kernel@vger.kernel.org
Message-id: <200507181244.40583.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <42DBB18E.7090707@xenomai.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 July 2005 09:41, Philippe Gerum wrote:
>The interrupt pipeline patch v0.9-02 has been released, fixing a
> latency spot and a bug in the deferred printk() mechanism.
>
>A split version of the patch for x86, ppc32 and ia64 is available
> here: http://download.gna.org/adeos/patches/v2.6/ipipe/split/
>
>Patch sequence to build a Linux 2.6.12 tree with I-pipe support:
>
>http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
>http://download.gna.org/adeos/patches/v2.6/ipipe/ipipe-2.6.12-v0.9-0
>2.patch

Will this then work with emc?  emc, when run, loads the adeos stuff, 
then unloads it when its stopped.  emc being the linux cnc machine 
controller.

If it will, I'd like to play with it on a bdi-4.20 install.

Or is this a seperate patch?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
