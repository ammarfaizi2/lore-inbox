Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131795AbQJ2PCW>; Sun, 29 Oct 2000 10:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131800AbQJ2PCR>; Sun, 29 Oct 2000 10:02:17 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:36112 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S131795AbQJ2PBz>; Sun, 29 Oct 2000 10:01:55 -0500
Date: Sun, 29 Oct 2000 16:01:53 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Broken colors on console with 2.4.0-textXX
Message-ID: <Pine.LNX.4.21.0010291558550.15902-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Console colors are completely messed up (read: black, I even suspect
the font to be corrupt somehow) if switching back to console mode
from X (either by quitting or ctrl-alt-fX) in recent 2.4.0-textXX
kernels. 2.2.XX do work just fine. Is this a known problem with a
known fix?

Setup: standard VGA console, nothing special. ATI Mach64 Xserver which
is fine with 2.2.XX

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
