Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUBVTL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 14:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUBVTL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 14:11:29 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:2785 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261726AbUBVTL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 14:11:28 -0500
Subject: os_wait_semaphore     : Failed to acquire semaphore[dff6e680|1|0],
	AE_TIME
From: Matthias Hentges <mailinglisten@hentges.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077477086.20597.11.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 22 Feb 2004 20:11:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm running 2.6.3-mm2 on Debian SID with gcc 3.3.3 (Debian) and my logs
are spammed with the following message:

Feb 22 20:01:24 mhcln03 kernel:      osl-0886 [218724]
os_wait_semaphore     : Failed to acquire semaphore[dff6e680|1|0],
AE_TIME

I've searched Google about this issue but didn't find anything helpful.

Since this system (a Centrino laptop) is running fine (besides borked
ACPI resume-to-$ANYTHING ) i wonder what this message is trying to tell
me.

Details about this laptop (dmesg, lspci etc) can be found here:

http://www.hentges.net/howtos/samsung_p30_hwspecs.html

TIA & HAND

PS: Please excuse the line breaks. Evolution in SID is kinda borked....
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody. Geek by Nature, Linux by Choice


