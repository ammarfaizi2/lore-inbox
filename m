Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267749AbTBVAvt>; Fri, 21 Feb 2003 19:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTBVAvt>; Fri, 21 Feb 2003 19:51:49 -0500
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:23764 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S267749AbTBVAvs>; Fri, 21 Feb 2003 19:51:48 -0500
Date: Sat, 22 Feb 2003 02:00:13 +0100 (CET)
From: Martijn Uffing <mp3project@cam029208.student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: Older bk snapshots not found on www.kernel.org (fwd)
Message-ID: <Pine.LNX.4.44.0302220158540.16168-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UTwente-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ave people.

I know www.xx.kernel.org has nice bk snapshots in the form 
of patch-2.5.x-bkx.gz  However,they are only against the latest linus 
release. The problem is I have a 100% repeatable OOPS in 2.5.62 while 
2.5.61 worked.  Before I send in a bug report I want to nail it down to 
which bk snapshot starts failing to make it a little easier for the 
bughunters to find the bug.  Is there any website/ftp whatever which 
collects older bk snapshots?


And if the maintainer of www.kernel.org reads this. May I suggest to keep 
the bk snaphots of let's say the last 4/5 linus releases. Then people like 
me who test the kernel a couple of days after release can start a bug hunt 
and test bk snaphots from the past.

Greetz
Mu






