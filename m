Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTKSQJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 11:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTKSQJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 11:09:22 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:41148 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S263893AbTKSQJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 11:09:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: couple of long standing minor notes
Date: Wed, 19 Nov 2003 11:09:18 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311191109.18936.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.54.127] at Wed, 19 Nov 2003 10:09:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings guys;

2 things of note, both of which have existed for a while.

1. My logs are sprinkled with:
Nov 19 09:55:53 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Nov 19 09:57:18 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Nov 19 10:42:15 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)

mobo is a Biostar M7-VIB, about 2 years old, uses this chipset.  The 
onboard sound itself seems to be working pretty good, although a new 
mail message from kmail has locked up xmms's access to the audio 
system on several occasions.

2.  Since about 2.6.0-test9-mm2, I see that the cannaserver startup 
during the boot, or if I do a service canna restart, says it failed, 
but it does not, the chinese etc characters display just fine in the 
spam, and a ps -ea|grep canna says its running.

These aren't show-stoppers by any means.  Just something to file away 
in the trivia box, and fix when somebody stumbles over that code. 

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

