Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266845AbRGFVBK>; Fri, 6 Jul 2001 17:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266846AbRGFVBB>; Fri, 6 Jul 2001 17:01:01 -0400
Received: from gate.tuxia.com ([213.209.134.221]:34033 "EHLO
	exchange1.win.agb.tuxia") by vger.kernel.org with ESMTP
	id <S266845AbRGFVAx> convert rfc822-to-8bit; Fri, 6 Jul 2001 17:00:53 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.4418.65
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Trouble Booting Linux PPC On Mac G4 2000
Date: Fri, 6 Jul 2001 23:00:53 +0200
Message-ID: <A16915712C18BD4EBD97897F82DA08CD409EEE@exchange1.win.agb.tuxia>
Thread-Topic: why this 1ms delay in mdio_read?  (cont'd from "are ioctl calls supposed to take this long?")
Thread-Index: AcEGSafKEB1r4/3ASduBA4+FdOMHdgABBLGwAAMhu+A=
From: "Tim McDaniel" <tim.mcdaniel@tuxia.com>
To: <linux-ppc@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are having a great degree of difficulty getting Linux PPC20000
running on a Mac G4 466 tower with 128MB of memory, One 30MB HD and one
CR RW. This is not a NuBus based system. To the best of our knowledge we
have followed the user manual to the tee, and even tried forcing video
settings at the Xboot screen.   


But still, when we encounter the screen where you must chose between
MacOS and Linux and we chose linux, the screen goes black and for all
practical purposes the box appears to be locked.   We've also tried
editing yaboot.conf but can't seem to save the new file.

Any help would be greatly appreatiated.

Tim 
