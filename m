Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267975AbRGVNKX>; Sun, 22 Jul 2001 09:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267976AbRGVNKO>; Sun, 22 Jul 2001 09:10:14 -0400
Received: from femail22.sdc1.sfba.home.com ([24.0.95.147]:39162 "EHLO
	femail22.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S267975AbRGVNKA>; Sun, 22 Jul 2001 09:10:00 -0400
Message-ID: <3B5AD0DF.8DDC5D1E@home.com>
Date: Sun, 22 Jul 2001 08:10:55 -0500
From: Steven Lass <stevenlass1@home.com>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug: 2.4.[<=6] kernel has Cyrix 'coma' bug?
Content-Type: multipart/mixed;
 boundary="------------22DA69911B5B974812BF17FD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------22DA69911B5B974812BF17FD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


dev-list,

Every 2.4 kernel that I've tried freezes my Cyrix MediaGX system at boot
up.

Typically the last messages displayed are:

Working around Cyrix MediaGX virtual DMA bugs 
CPU: Cyrix Media GX Core/Bus Clock Stepping 02 
Checking 'hlt' instruction

Occasionally, the "Checking 'hlt' instruction" is not displayed before
it freezes.

My system is a PowerSpec Model 1810 (no laughs please), my Phoenix BIOS
reports "Cyrix GX 3.2 180MHz".

I've compiled/installed numerous 2.2.x kernels w/o any trouble.  The
Redhat 7.1 CDROM image freezes at boot.  I've compiled the 2.4.4, 2.4.5,
& 2.4.6 kernels with various config settings, but they all freeze at
boot.  I'm currently running redhat 7.0, so I've tried compiling with
gcc (gcc 2.96 20000731) & kgcc (egcs 1.1.2 release), no luck.
 
I'm willing to compile the 2.4.[<4} kernels or try any other
pre-compiled kernels is anyone has a suggestion.

Please CC: me on any response
-steve
--------------22DA69911B5B974812BF17FD
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3B5A453E.15B631F9@home.com>
Date: Sat, 21 Jul 2001 22:15:10 -0500
From: Steven Lass <stevenlass1@home.com>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: stevenlass@mail.com
Subject: bug: 2.4.[<=6] kernel has Cyrix 'coma' bug?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


dev-list,

Every 2.4 kernel that I've tried freezes my Cyrix MediaGX system at boot
up.

The point at which it hangs varies, but typically the last messages
displayed are:

Working around Cyrix MediaGX virtual DMA bugs
CPU: Cyrix Media GX Core/Bus Clock Stepping 02
Checking 'hlt' instruction

My system is a PowerSpec Model 1810 (no laughs please), my Phoenix BIOS
reports "Cyrix GX 3.2 180MHz".

I've compiled/installed numerous 2.2.x kernels w/o incident.  The Redhat
7.1 CDROM image freezes.  I've compiled the 2.4.4, 2.4.5, & 2.4.6
kernels with various config settings, but they all freeze.  I'm
currently running redhat 7.0, so I've tried compiling with gcc (gcc 2.96
20000731) & kgcc (egcs 1.1.2 release), no luck.
 
I'm willing to compile the 2.4.[<4} kernels or try any other
pre-compiled kernels is anyone has a suggestion.

Please CC: me on any response
-steve


--------------22DA69911B5B974812BF17FD--

