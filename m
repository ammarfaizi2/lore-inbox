Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRDCM0K>; Tue, 3 Apr 2001 08:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRDCM0B>; Tue, 3 Apr 2001 08:26:01 -0400
Received: from www.teaparty.net ([216.235.253.180]:17421 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S131307AbRDCMZ4>;
	Tue, 3 Apr 2001 08:25:56 -0400
Date: Tue, 3 Apr 2001 13:25:15 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: linux-kernel@vger.kernel.org
Subject: SMP aic7xxx 2.4.3 boot panic: Aiee, killing interrupt handler
Message-ID: <Pine.LNX.4.10.10104031314440.18250-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone else had this or a similar problem? I tried to upgrade to 2.4.3
from 2.2.18 recently, but I invariably got a kernel panic on boot - I ran
the oops through ksymoops, and it seemed to indicate that the problem
occurred while in the aic7xxx driver [although I may, of course, be
misinterpreting the ouput hideously]

I'm, going to try the old aic7xxx driver tonight, to see if that works any
better.

[I posted the oops a couple of days ago, and I don't want to spam the
 list with it again, but if anyome is interested in the output, I'd be
 happy to send it, pluys any extra details required... ]

-- 
"They're unfriendly, which is fortunate, really.  They'd be difficult
to like."
                -- Avon

