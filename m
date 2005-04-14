Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVDNDfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVDNDfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 23:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVDNDfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 23:35:18 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:28872 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261424AbVDNDfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 23:35:13 -0400
Date: Wed, 13 Apr 2005 23:35:12 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: iproute/iptables best?
To: linux-kernel@vger.kernel.org
Message-id: <200504132335.12324.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scenario:

1 machine, two net cards, two networks

How can we make the reply to an action go back out through the route 
it came in on?  As it exists, queries, ssh sessions etc coming in 
thru a vpn from one router are being replied to on the default 
gateways card that hits the other network.

Is iptables the best tool, or is iproute2 the best tool to do this?

Pointers to good docs etc appreciated.  Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
