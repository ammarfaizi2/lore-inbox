Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272432AbTHOXpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272453AbTHOXpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:45:42 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:39887 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S272432AbTHOXpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:45:35 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: usblp suddenly has mental problems
Date: Fri, 15 Aug 2003 19:45:33 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308151945.33976.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.12.137] at Fri, 15 Aug 2003 18:45:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

This is regardless of the kernel booted to.  I've now tried 
2.4.22-rc2, 2.4.21, and 2.4.20.  And we all know that 2.6.0-test3-mm2 
is still broken.

Summary:

Cups from mozilla's accessing its web page (localhost:631) can print a 
test page just fine to either printer.  I've got 2 Epson usb printers 
plugged in, really I do!

*Any* other attempt to get ink on the paper, regardless of the method, 
down to and including 'lpr filename', gets me about the right amount 
of paper spit out for the job, but instead of the text, it is covered 
from bleed to bleed in all 4 sides with a flat, even medium grey, 
about twice as bright as a kodak 18% card.  I've now got about 35 
such sheets in the bin from trying to print a letter, composed 
originally in kwrite.  The first attempt from the kwrite print menu 
worked, but even that hasn't worked in about an hour now.  But the 
cups test page is still fine.

ATM I'm back on a 2.4.2-rc2 boot, the printer has been turned off to 
recycle it several times without effecting this, and I'm out of hair.  
Hell, I've even re-installed cups-1.1.19!  I eventually sent the 
letter off by email, which will not be near as effective as ink.

This lashup has worked flawlessly for several months.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

