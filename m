Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVCTWKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVCTWKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVCTWKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:10:25 -0500
Received: from 63.reserved.callplus.net.nz ([203.184.21.63]:11795 "EHLO
	brick.flying-brick.caverock.net.nz") by vger.kernel.org with ESMTP
	id S261297AbVCTWKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:10:16 -0500
Date: Mon, 21 Mar 2005 10:09:25 +1200
From: viking <viking@flying-brick.caverock.net.nz>
To: linux-kernel@vger.kernel.org
Cc: Wakko Warner <wakko@animx.eu.org>
Subject: USB mouse hiccups (was RFD: Kernel release numbering)
Message-ID: <pan.2005.03.20.21.53.36.929746@brick.flying-brick.caverock.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Flying Brick Systems
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-blather-
It took a few days before I actually saw this posting. I also agree that
2.6.10 seems to be more stable than 2.6.11 - mind you, that could be
because I'm using 2.6.10-linus (i.e. the tarball from the linux.org site)
and the 2.6.11 is a Mandrake-ised kernel + Linus patches - at least I
*think* they're Linus' patches - no Visual Basic in them yet.
I've also noted .10 is quicker off the blocks than 2.6.11 seems to be.

-meat-
I did note something strange. I'm running 2.6.11.2 at this moment, when I
tried 2.6.11.3, my USB Microsoft Wireless Optical Mouse stopped moving
from left to right, and would only move up and down if I physically moved
the mouse from left to right. I didn't see anything in the patches that
touched anything in the event handling, so frankly I'm puzzled.
Any clues as to where I need to look? I've seen this problem before, but
don't know what causes it, nor how I fixed it at the time.
Also, how do I get that patch that enables the tiltwheel (left-right
events)?

-blather-
I'll try out .5 once I fetch the patch and spend another three hours on my
cluster, compiling. Again. The reason I haven't dipped into real testing
of kernels was precisely for this reason, that I didn't want to have to
spend absolutely ages waiting for a compile. However, I've finally decided
to dip my toes back in the water, with the 2.6.11 series...

Love the Suspend-to-disk... only wish I could load a saved image into a
later kernel, though I understand why this can't be done. That would be my
current "killer app".

'Nuff mumbling.

CC if you wish, but I ought to be watching the list again for this one.

-- 
 /|   _,.:*^*:.,   |\  Cheers from the Viking family, including Pippin, our cat
| |_/'  viking@ `\_| |
|    flying-brick    | $FunnyMail   : What do you mean, I've lost the plot?
 \_.caverock.net.nz_/     5.40      : I planted them carrots right here!!

-- 
 /|   _,.:*^*:.,   |\  Cheers from the Viking family, including Pippin, our cat
| |_/'  viking@ `\_| |
|    flying-brick    | $FunnyMail   : What do you mean, I've lost the plot?
 \_.caverock.net.nz_/     5.40      : I planted them carrots right here!!
