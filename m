Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWACRuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWACRuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWACRuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:50:52 -0500
Received: from mail.dvmed.net ([216.237.124.58]:2193 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932471AbWACRuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:50:50 -0500
Message-ID: <43BAB977.3010203@pobox.com>
Date: Tue, 03 Jan 2006 12:50:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Happy New Year, libata hackers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.6 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Well, another year has passed, and somehow the duct
	tape that keeps our hard drives together has remained intact. After a
	nice and refreshing holiday, I have a bunch of patches pending, that
	will probably take a week or two to sort through. [...] 
	Content analysis details:   (0.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, another year has passed, and somehow the duct tape that keeps our 
hard drives together has remained intact.  After a nice and refreshing 
holiday, I have a bunch of patches pending, that will probably take a 
week or two to sort through.

For 2.6.16, my main goals are getting irq-pio upstream and supporting 
iomap -- which will kill all those annoying warnings finally.  And 
probably some EH work from Tejun will go in too.  The suspend/resume 
stuff is shaping up nicely, and device hotplug work suddenly reappeared. 
  Fun for all.

Port multiplier and NCQ (queueing) support are the two other big to-do 
items on the list.

I updated the hardware status report at
	http://linux.yyz.us/sata/

and will update the software status report in a week or two.

Everybody wants to play in the same sandbox, so please be patient as we 
sort it all out.

Cheers and happy new year,

	Jeff



