Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270382AbRHSNDQ>; Sun, 19 Aug 2001 09:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270385AbRHSNDG>; Sun, 19 Aug 2001 09:03:06 -0400
Received: from relay.kiev.sovam.com ([212.109.32.5]:46863 "EHLO
	relay.kiev.sovam.com") by vger.kernel.org with ESMTP
	id <S270382AbRHSNCv>; Sun, 19 Aug 2001 09:02:51 -0400
Date: Sun, 19 Aug 2001 16:06:18 +0300
From: "Serguei I. Ivantsov" <administrator@svitonline.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Serguei I. Ivantsov" <administrator@svitonline.com>
Organization: IvantSoft Inc.
X-Priority: 3 (Normal)
Message-ID: <1021859034.20010819160618@svitonline.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x & Celeron = very slow system
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have a BIG problem with 2.4.x kernels.

With 2.4.x kernel my system (Celeron (Coppermine) 850Mhz (100x8.5)
256Mb i810) behaves like slow i386sx.

For example, when I extract 25MB gzip file on 2.2.19 kernel - it
takes about 12 seconds, but with 2.4.8(9) - 6(!) MINUTES on the SAME
system...

The only idea is that 2.4.x kernel turns off cache (L1 & L2) on
processor (on my cpu). How can I check it? Any ideas?


-- 
Best regards,
 Serguei                          mailto:administrator@svitonline.com

