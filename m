Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132411AbQLVXRC>; Fri, 22 Dec 2000 18:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132444AbQLVXQx>; Fri, 22 Dec 2000 18:16:53 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:35085 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S132411AbQLVXQr>; Fri, 22 Dec 2000 18:16:47 -0500
From: Norbert Preining <preining@logic.at>
Date: Fri, 22 Dec 2000 23:46:10 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ALi agpgart patch for 2.4.0-test12
Message-ID: <20001222234610.A12203@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried the patch with an Asus P5A-B + AMD K6-II 333, the
ALi 1541 and it works very well. With the patches from the
irc channel #nvidia for ali-agp it was working but only in
1x agp mode, SBA and FW disabled. With this patch now I can
run 2x agp mode and don't crash my system when playing 3D
like terminus or descent3.

Best wishes

Norbert

-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
