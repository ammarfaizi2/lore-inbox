Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131833AbRANLUN>; Sun, 14 Jan 2001 06:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131947AbRANLUD>; Sun, 14 Jan 2001 06:20:03 -0500
Received: from IP1A0086.ygt.mesh.ad.jp ([211.13.76.214]:55303 "EHLO
	suika.yamamoto.gr.jp") by vger.kernel.org with ESMTP
	id <S131833AbRANLTv>; Sun, 14 Jan 2001 06:19:51 -0500
Message-Id: <200101141119.AA04362@karima.yamamoto.gr.jp>
Date: Sun, 14 Jan 2001 20:19:40 +0900
To: linux-kernel@vger.kernel.org
Subject: Problems of at1700.c
From: sawa <sawa@yamamoto.gr.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.11
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] at1700.c contains 2 bugs.
[2.] (1) at1700.c v1.15 with glibc 2.1 (e.g. RedHat 6.2) often hangs up.
     (2) Multicast does not work.
[3.] networking, Ethernet, at1700, fmv18x
[4.] 2.2.14 and later
[X.] Please include Tamiya's patch.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
