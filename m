Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUJRUXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUJRUXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUJRUWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:22:44 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:5603 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S263962AbUJRUUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:20:51 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: back to -rc4
Date: Mon, 18 Oct 2004 16:20:49 -0400
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410181620.49829.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.58.180] at Mon, 18 Oct 2004 15:20:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all;

Just a note to say that I've rebooted to 2.6.9-rc4, final is doing 
something to the x apps.  I've had mozilla 1.7.3 crash silently 5 or 
6 times since I booted to final, and kmail just died the same way 6 
times in about 20 minutes.  When they go away, you can click on the 
close button, and the system will eventually ask if you want to kill 
the app, so you do.  And when you restart it, the app has been 
totally restored to the place it was when it went out for lunch, and 
works normally again till the next time.

There are no messages in the logs when this occurs.  The only 
difference in the .config is I had turned an ATI option on in the agp 
section.

I'll turn it back off and try 2.6.9-final again.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
