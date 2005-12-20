Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVLTTyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVLTTyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVLTTyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:54:50 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:37043 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932067AbVLTTyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:54:49 -0500
Date: Tue, 20 Dec 2005 15:05:43 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Sensors errors with 15-rc6, 15-rc5 was normal
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200512201505.43199.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To whomever is in charge of the sensors code in the kernel:

I just noted that the temperatures being reported by gkrellm, using its 
internal sensors stuff, are not correct by over 100F too low when -rc6 
is running.  -rc5 seems to give good readings consistent with what 
I've been observing for the last year, a slowly rising cpu reading due 
to the zallman flower becoming dust packed, to the point of about 150F 
for a normal reading.

Today, after rebooting to -rc6, I'm seeing cpu temps ranging between 
39.2 and 41.7 degress F. As the room is probably around 74F, thats a 
bit of a dubious reading.

Whom do I contact about this? 

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should use this
address: <gene.heskett@verizononline.net> which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
