Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129997AbRBLARx>; Sun, 11 Feb 2001 19:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130682AbRBLARc>; Sun, 11 Feb 2001 19:17:32 -0500
Received: from lindy.SoftHome.net ([204.144.232.9]:6406 "HELO
	lindy.softhome.net") by vger.kernel.org with SMTP
	id <S129997AbRBLARX>; Sun, 11 Feb 2001 19:17:23 -0500
Message-ID: <20010212004402.3433.qmail@lindy.softhome.net>
To: linux-kernel@vger.kernel.org
Subject: ext2: block > big ?
Date: Sun, 11 Feb 2001 17:44:02 -0700
From: Brian Grossman <brian@SoftHome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What does a message like 'ext2: block > big' indicate?

This was kernel 2.2.18aa2.

The machine was completely unresponsive when I got there.  There were a
bunch of block>big messages on the screen, but no oops.

In my grogginess, I didn't have the sense to copy down the whole message,
but it did also mention the device (8,9?).  The major 8 scsi devices in use
are three partitions of one disk -- two 15GB and one 50GB.

Brian
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
