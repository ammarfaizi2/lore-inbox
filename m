Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVGRVYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVGRVYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 17:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVGRVYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 17:24:52 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:37620 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261899AbVGRVYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 17:24:52 -0400
Date: Mon, 18 Jul 2005 17:24:56 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: RT-V0.7.51-31 vs ntpd, 1 to nothin so far
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Message-id: <200507181724.56755.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo;

I just built 51-31, mode 4, and although I spent an hour putting in 
debug printouts in /etc/init.d/ntpd, I couldn't make it work, and 
the /var/log/ntpd.log is being flooded with "bad file descriptor" 
messages.

So I'm back on 51-30 in mode 3 for the time being so tvtime works.
 
-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
