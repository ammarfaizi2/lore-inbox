Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRAGNbw>; Sun, 7 Jan 2001 08:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131871AbRAGNbm>; Sun, 7 Jan 2001 08:31:42 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:25098 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S131672AbRAGNbc>;
	Sun, 7 Jan 2001 08:31:32 -0500
Date: Sun, 7 Jan 2001 19:01:06 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Kdb for modules
Message-ID: <Pine.SOL.3.96.1010107184944.24088A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	For using kdb I have done the following:
	1) upgrade modutils using modutils-2.3.11-1.i386.rpm
	2) patched the source using kdb-v0.6-2.2.13 as I am using
	   linux-2.2.16.(I don't know, this kdb for 2.2.13 works for
	   linux-2.2.16, I haven't used it extensively, so don't know 
	   whether it works correctly or not?, but I couldn't find kdb
	   for 2.2.16 in SGI site, any clues in this is very much 
	   welcomed  :))

	so this works ... , 
	But if I want to debug the modules, set breakpoints at, see the
	address of, module functions, what shall I have to do? I haven't 
	found any clue on this as yet, Plz. help..

sourav
--------------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
