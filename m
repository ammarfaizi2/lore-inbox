Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131301AbRAUAWJ>; Sat, 20 Jan 2001 19:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbRAUAV7>; Sat, 20 Jan 2001 19:21:59 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:34254 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S130758AbRAUAVu>; Sat, 20 Jan 2001 19:21:50 -0500
Message-ID: <3A6A2B9A.5F40CA04@gmx.de>
Date: Sun, 21 Jan 2001 01:21:46 +0100
From: Tobias Burnus <burnus@gmx.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tobias Burnus <burnus@gmx.de>
Subject: Ethernet drivers: SiS 900, Netgear FA311
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think those drivers have not yet been merged. Since I happend to have
those (and had problem to get them run with the default kernel) I'd like
to asked whether those can be included into the kernel. They are GNU
licensed. Seemingly the SiS updates the existing sis900 driver, the
FA311 is not yet supported by the kernel.

http://www.sis.com.tw/ftp/Drivers/linux/630s/
 readme.txt              13-Nov-2000 03:58     3k  
 sis900.c                13-Nov-2000 03:58    46k  
 sis900.h                13-Nov-2000 03:58     9k  

http://www.netgear-support.com/ts/pwtservicepacks.cfm?spc=0&ss=FA311&sortby=0
(e.g. fa311lx.zip:
-rw-rw-rw-           48047 Aug 24 22:36 fa311.c
-rw-rw-rw-           33203 Aug 24 22:36 fa311.h
-rw-rw-rw-            7820 Aug 24 22:36 fa311.o
-rw-rw-rw-             131 Aug 24 22:36 makefile

Tobias
-- 
This above all: To thine own self be true / And it must follow as
the night the day / Thou canst not then be false to any man.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
