Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUEWLvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUEWLvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 07:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUEWLvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 07:51:54 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:41434 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262606AbUEWLvw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 07:51:52 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: scsi debugging question
Date: Sun, 23 May 2004 07:51:51 -0400
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405230751.51331.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.56.33] at Sun, 23 May 2004 06:51:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I have one of the advansys cards, and since the original check_region 
patch has been reverted now, I thought I'd turn on scsi debugging 
(kernel size += 12k) in my kernel build, and have rebooted to that 
2.6.6-mm5 kernel well before last nights amanda run.

However, no additional data seems to have been generated, either 
in /var/log/messages, nor anyplace else in the /var/log tree.

If it was generated, where did it go?

Amanda moved about 5 Gb of data thru that card ;ast night, and that 
*should* have generated some noise someplace I'd think.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.23% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
