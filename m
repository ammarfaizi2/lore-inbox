Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbRCGS1R>; Wed, 7 Mar 2001 13:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRCGS1H>; Wed, 7 Mar 2001 13:27:07 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:49932 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S131143AbRCGS0z>;
	Wed, 7 Mar 2001 13:26:55 -0500
Date: Wed, 7 Mar 2001 23:56:12 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: kernelnewbies@humbolt.nl.linux.org, lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.2-ac
Message-ID: <Pine.SOL.3.96.1010307234516.22645A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I have patched 2.4.2 with patch-2.4.2-ac9. At make xconfig turned
all kernel hacking options on. Then make dep and make bzImage went on ok.
But when I put the image path in lilo.conf and ran /sbin/lilo it said
kernel /abc/pqr/..../vmlinux is too big.

	Whats going wrong. My gcc is egcs-2.91.66. The running kernel is
2.2.14-5.0.

thanks
sourav
--------------------------------------------------------------------------------
SOURAV SEN    MSc(Engg.) CSA IISc BANGALORE URL : www2.csa.iisc.ernet.in/~sourav 
ROOM NO : N-78      TEL :(080)309-2454(HOSTEL)          (080)309-2906 (COMP LAB) 
--------------------------------------------------------------------------------
"the fault, dear Brutas, lies not in our stars, but in our memory systems"
								-Shakespeare

