Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbUAMRoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUAMRoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:44:19 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:1956 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264463AbUAMRna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:43:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: ANother debugging Q
Date: Tue, 13 Jan 2004 12:43:27 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401131243.27614.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.56.190] at Tue, 13 Jan 2004 11:43:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all;

I have a problem running a kde app (ksysguard or kpm) that forks the 
actual app from the script that runs it, but the actual app itself 
has connection problems.  An strace only traces the apps invocation 
up to the point of the fork call, and it is therefore no help with 
the application proper as it doesn't get traced.

Is there a way to make the app itself inherit the strace so that its 
errors can be located/defined and fixed?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

