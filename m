Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270082AbTHBRpt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 13:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270093AbTHBRpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 13:45:49 -0400
Received: from pdbn-d9bb864b.pool.mediaWays.net ([217.187.134.75]:28937 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S270082AbTHBRps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 13:45:48 -0400
Date: Sat, 2 Aug 2003 19:45:40 +0200 (CEST)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: System locks up hard when i delete a file while burning a DVD-R
 (seems reiserfs related)
Message-ID: <Pine.LNX.4.44.0308021930440.2741-100000@korben.citd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi




Today it happened to me twice that i deleted a file (both around 400MB)
while i burned a DVD from the same partition. (Second time was a
"mistake", i deleted the file 10 minutes earlier and the system locked up
the moment the program, that had the file open, terminated)

The system just locked up hard, cdrecord was able to show a "sense key"
error (sorry, haven't written the message down) and then i had to press
the big red switch.

Kernel is 2.4.21 with only loop-aes-patch (wasn't in used)
System is a Dual-PIII-933Mhz.
Data-HDD is "standard" IDE drive. Connected to a Highpoint RocketRAID 1540
(374 Chipset)
DVD-Burner is connected via Firewire.

If any more details are need, i will provide them.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.


