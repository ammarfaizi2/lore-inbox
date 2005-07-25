Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVGYOUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVGYOUO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVGYOUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:20:14 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:55281 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261158AbVGYOUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:20:12 -0400
Date: Mon, 25 Jul 2005 10:20:08 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Question re the dot releases such as 2.6.12.3
To: linux-kernel@vger.kernel.org
Message-id: <200507251020.08894.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just built what I thought was 2.6.12.3, but my script got a tummy 
ache because I didn't check the Makefile's EXTRA_VERSION, which was 
set to .2 in the .2 patch.  Now my 2.6.12 modules will need a refresh 
build. :(

So whats the proper patching sequence to build a 2.6.12.3?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
