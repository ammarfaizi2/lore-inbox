Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131086AbRADRy2>; Thu, 4 Jan 2001 12:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbRADRyI>; Thu, 4 Jan 2001 12:54:08 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:21677 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131086AbRADRx5>; Thu, 4 Jan 2001 12:53:57 -0500
Date: Thu, 4 Jan 2001 12:53:37 -0500 (EST)
From: Shane Shrybman <shane@zeke.yi.org>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: VIA686a test code... reset the latch if count > max
Message-ID: <Pine.LNX.4.21.0101041245360.21405-100000@zeke.goatskin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have just been bit by this bug(hardware?) while using the
2.4.0-prerelease kernel. The fix has been included in recent
2.2.19pre kernels and I was wondering if there are plans to
include it in 2.4. It requires a reboot to repair so it is
a bit of a problem ;)

Also, is it a confirmed hardware bug?

Thanks for the great work so far,

Shane


-- 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
