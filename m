Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWBGQvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWBGQvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWBGQvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:51:19 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:39841 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932464AbWBGQvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:51:18 -0500
Date: Tue, 07 Feb 2006 11:41:27 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Odd line in 2.6.16-rc2 boot sequence log
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200602071141.27474.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to the sensors people;

There is a line output to the screen during the aftermath of 
initializing the sensors that I didn't think was making it to the logs, 
but I just found it:
---------
Feb  6 22:01:36 coyote kernel: Driver 'w83627hf' needs updating - please 
use bus_type methods
---------
I went back and looked around in the xconfig, but nothing jumps up and 
taps me on the knee there.

My sensors are working ok according to gkrellm.  Is this temporary and 
self-healing in future releases, or even something to worry about?  
Worse yet, will it break gkrellm eventually?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
