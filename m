Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129858AbRBAReo>; Thu, 1 Feb 2001 12:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130654AbRBAReZ>; Thu, 1 Feb 2001 12:34:25 -0500
Received: from [213.209.134.221] ([213.209.134.221]:40441 "EHLO
	pluto.agb.tuxia") by vger.kernel.org with ESMTP id <S130212AbRBAReM>;
	Thu, 1 Feb 2001 12:34:12 -0500
Date: Thu, 1 Feb 2001 18:32:31 +0100
From: Juergen Schneider <juergen.schneider@tuxia.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Animated framebuffer logo for 2.4.1
Message-ID: <20010201183231.A373@tuxia.com>
Reply-To: Juergen Schneider <juergen.schneider@tuxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Organization: TUXIA Deutschland GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I've created a patch for kernel 2.4.1 that adds some fancy options for
the framebuffer console driver concerning the boot logo.
I've added logo animation and logo centering.
People may find this not very useful but nice to look at. :-)

It can be downloaded from:
   <ftp://ftp.tuxia.com/pub/linux/tuxia/anim-logo/AnimLogo.tgz>

With this tar ball comes the patch for kernel 2.4.1 and a small
program called xpm2splash to create animated linux_logo.h files
from XPM files.
The patch also contains an animated boot logo (that's why it is
so big).
It is the dancing penguin I've taken from the apache default
configuration of a SuSE 6.4 distribution.
(BTW who created this nice animation???)

So, try it and send your comments.

Juergen Schneider

PS: The patch should work with kernel 2.4.0 too.

PPS: Our FTP server seems to have some problems with the "ls"
     command. You should use "ls -l" or "dir" to get a
     directory listing. Sorry for that.

-- 
Dipl.-Inf. Juergen Schneider                    <juergen.schneider@tuxia.com>
TUXIA Deutschland GmbH
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
