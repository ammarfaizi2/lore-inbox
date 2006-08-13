Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWHMM0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWHMM0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 08:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWHMM0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 08:26:20 -0400
Received: from razorback.tcsn.co.za ([196.41.199.53]:52997 "EHLO tcsn.co.za")
	by vger.kernel.org with ESMTP id S1751145AbWHMM0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 08:26:20 -0400
Date: Sun, 13 Aug 2006 14:27:11 +0200
From: Henti Smith <henti@geekware.co.za>
To: linux-kernel@vger.kernel.org
Subject: upgrading pentavalue drivers from 2.4 to 2.6
Message-ID: <20060813142711.2cccf6c3@yoda.foad.za.net>
Organization: Geek Ware
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys, 

I have a client that uses pentavalue DVB-S cards pretty much all over
their business, however the drivers has not been updated since 2002
(2.4 kernel only) I've spoken to the dev's at the company and they are
not interested in doing drivers for 2.6

The 2.4 drivers they released is source code format, however I could
not find any clear indication of licence agreements to use the code for
further development. 

I'm hoping that it's GPL'ed since MODULE_LICENSE("GPL"); appears in the
pentadrv.c and scanval.c files

I'm going to contact them again to confirm we can use the code for
2.4 to upgrade to 2.6 and possible include in the kernel source (if it
will be allowed :P) 

Lastly .. and the reason I'm mailing is .. I'm looking for somebody
that is keen on  doing the port .. I'll happily supply hardware (we
have lots of these cards) 

beer or other incentives can be negotiated ;P 

Thanks :) 

-- 
Henti Smith
henti@geekware.co.za
+27 82 958 2525
http://www.geekware.co.za

DISCLAIMER : 

Unauthorised use of characters, images, sounds, odors, severed limbs,
noodles, wierd dreams, strange looking fruit, oxygen, and certain parts
of Jupiter are strictly forbidden.  If I find you violating, or
molesting my property in any way, I will employ a pair of burly
convicts to find you, kidnap you, and perform god-awful sexual
experiments on you until you lose the ability to sound out vowels.  I
don't know why you are still reading this, but by doing so you have
proven that you have far too much time on your hands, and you should go
plant a tree, or read a book or something.
	- http://www.ctrlaltdel-online.com/
