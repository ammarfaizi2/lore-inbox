Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272639AbTHPIjE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 04:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272647AbTHPIjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 04:39:04 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:23170 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP id S272639AbTHPIjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 04:39:02 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: increased verbosity in dmesg
Date: Sat, 16 Aug 2003 04:38:59 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308160438.59489.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [151.205.12.137] at Sat, 16 Aug 2003 03:39:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

The recently increased verbosity in the dmesg file is causeing the 
"ring buffer" to overflow, and I am not now seeing the first few 
pages of the reboot in the dmesg file.

I understand this 'ring' buffer has been expanded to about 16k but 
that was way back in 2.1 days when that occured according to the 
Documentation.

Is there any quick and dirty way to increase this to at least 32k, or 
maybe even to 64k?  With half a gig of memory, this shouldn't be a 
problem should it?

I've done some grepping, but it appears I'm not grepping for the right 
var name, so I'm coming up blank and need some help.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

