Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRHRKCl>; Sat, 18 Aug 2001 06:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271801AbRHRKCb>; Sat, 18 Aug 2001 06:02:31 -0400
Received: from citd-ppp.paderlinx.de ([193.189.252.149]:51463 "EHLO
	mail.citd.de") by vger.kernel.org with ESMTP id <S271800AbRHRKCO>;
	Sat, 18 Aug 2001 06:02:14 -0400
Date: Sat, 18 Aug 2001 12:02:26 +0200 (MEST)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: Strange Slowdown
Message-ID: <Pine.LNX.4.20.0108181156140.5058-100000@citd.owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi



I have a Dual PII with 2GB-RAM on a GX-Chipset Mainboard (Tyan Thunder
100)

Until yesterday that machine ran with Kernel 2.2.19. After upgrading to
2.4.(4/9) it got about 20times SLOWER than with 2.2.19.

After i switched "High Memory-Support" to "OFF"(4GB Before) the speed went
to normal, but now less than half RAM is used.

Any suggestions?

(Kernel 2.2.19 ran with "Maximum Physical Memory = 2GB")




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


