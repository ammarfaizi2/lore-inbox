Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992476AbWJTFas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992476AbWJTFas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992478AbWJTFas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:30:48 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:42418 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S2992476AbWJTFas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:30:48 -0400
Date: Fri, 20 Oct 2006 01:30:44 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: 2.6.19-rc1, timebomb?
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200610200130.44820.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just arrived home a few hours ago, and my wife said the outside lights 
hadn't worked for the last 2 days.

I come in to check, the this machine, which runs some heyu scripts to do 
this, was powered down.  So I powered it back up and it had to e2fsk 
everything.  I have a ups with a fresh battery which passes the tests just 
fine.

The only thing in the logs is a single line about eth0 being down:
Oct 17 05:31:11 coyote kernel: eth0: link down.
Oct 19 20:37:49 coyote syslogd 1.4.1: restart.

Uptime when this occurred was about 9 days.  Was this a known problem?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
