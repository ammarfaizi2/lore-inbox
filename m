Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272058AbRIEOVu>; Wed, 5 Sep 2001 10:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272182AbRIEOV3>; Wed, 5 Sep 2001 10:21:29 -0400
Received: from [128.242.109.118] ([128.242.109.118]:26136 "EHLO ziplip.com")
	by vger.kernel.org with ESMTP id <S272058AbRIEOVU>;
	Wed, 5 Sep 2001 10:21:20 -0400
Message-ID: <JK3MT4ZNAEJNIG1ZEGEDMAZMT10XZKMHVJEFFMME@ziplip.com>
Date: Wed, 5 Sep 2001 07:22:27 -0700 (PDT)
From: noneuclidean <noneuclidean@ziplip.com>
Reply-To: noneuclidean <noneuclidean@ziplip.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Athlon doesn't like Athlon optimisation?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ZLExpiry: -1
X-ZLReceiptConfirm: N
X-ZLAuthUser: noneuclidean@ziplip.com
X-ZLAuthType: WEB-MAIL
X-ZLAuthOn: Y
X-Mailer: ZipLip Sonoma v3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Iwill KK266 (VIAKT133A chipset, latest BIOS) with an unlocked but not overclocked Athlon 950 (AMD Thunderbird, A4, Model 4). The system DOES suffer the Athlon optimisation problem.

I ran burnK7, burnK7 in linux 2.4.8ac11 (optimised for K6) and WinME for over 3 hours with no problems.

For ?fun? I also tried running 50 mulitiple instances (in total) of a mix of burnK7, burnMMX, burnBX, burnP6 and burnK6 in linux (with different memory settings for burnBX and burnMMX), while accessing floppy, CD-ROM, 2xHDDs, my SBLive card and my Geforce 2 to try and load my voltages... but again completely stable, if a bit... well very... jerky!.

I think the burnK7 program does not test enough K7 specific instruction sets to find the problem.

Jamal Conway
I am not on this list, please CC replies.
