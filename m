Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUE3BQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUE3BQD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 21:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUE3BQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 21:16:03 -0400
Received: from web14926.mail.yahoo.com ([216.136.225.84]:15959 "HELO
	web14926.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261418AbUE3BQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 21:16:01 -0400
Message-ID: <20040530011600.93607.qmail@web14926.mail.yahoo.com>
Date: Sat, 29 May 2004 18:16:00 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Change in gigabit vs 100Mb Ethernet Kconfig, 2.6.7-rc1
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The network Kconfig was just changed to require enabling 100Mb Ethernet before
you can see the 1Gb hardware.  This change is very non-intuitive, I was forced
into reading the Kconfig file to figure out how to re-enable my e1000 driver.
Can this be done some other way?

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
