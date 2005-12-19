Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVLSXIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVLSXIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 18:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVLSXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 18:08:21 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:4657 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S965028AbVLSXIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 18:08:20 -0500
Date: Mon, 19 Dec 2005 18:08:18 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: -rc6 vs desktop use, desktop 0
To: linux-kernel@vger.kernel.org
Message-id: <200512191808.18784.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I tried to rebuild rc6 without the size optimizations, but that 
resulted in some sort of a timer problem being logged at about 1 
second intervals to the vt's.

I'm back in rc5 now, cause rc6 is best described as a dog for desktop 
use, kmail freezes for 10 seconds at a time.  rc5 does do that nearly 
as bad.

Useing Con's scheduler as default in both cases.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should use this
address: <gene.heskett@verizononline.net> which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
