Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVALFAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVALFAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVALFAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:00:22 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:62449 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261228AbVALFAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:00:17 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: ieee1394 errors on attempted insmod
Date: Wed, 12 Jan 2005 00:00:15 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501120000.15177.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.12.118] at Tue, 11 Jan 2005 23:00:16 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just bought a Sony HandyCam DCR-TRV460, which has both firewire and 
usb ports.

But I couldn't seem to open a path to it using usb, so I plugged in an 
old firewire card that has the TI-Lynx chipset on it.  Its recognized 
(apparently) by both dmesg and kudzu, but although I'd turned on all 
the 1394 stuff as modules when I got ready to plug the card in and 
rebuilt my 2.6.10-ac8 kernel, kudzu didn't load any of them, and when 
I try to, I'm getting "-1 Unknown Symbol in module" errors. 

Probably an attack of dumbass, but I'd appreciate any help that can be 
tossed my way.  ATM I'm rebuilding again with the base module built 
in.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
