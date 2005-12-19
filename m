Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVLSR2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVLSR2i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVLSR2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:28:38 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:15257 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932268AbVLSR2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:28:37 -0500
Date: Mon, 19 Dec 2005 12:29:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: reboot from 2.6.15-rc5 wasn't clean
To: linux-kernel@vger.kernel.org
Message-id: <200512191229.03813.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all;

I just rebooted to 2.6.15-rc6, built with the new 'size' option on, but 
had some problems with the reboot process from -rc5.  Compiler is 
gcc-3.3.3-7.

When I killed X by logging out, I got a loud cacaphonic sound from 
artsd, and no keyboard echo could be seen in vt1 when I typed reboot.

And now, rebooted to -rc6, kmail is virtually unusable because the 
system feels as if something is hogging it 100% of the cpu time.
Echo's to the composer screen of what I type are 2 or more seconds 
being shown on screen too.

But according to kpm, everything looks kosher.  Weird.  Scheduler is 
CK's.

Does anybody have any suggestions?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should use this
address: <gene.heskett@verizononline.net> which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
