Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTBQO3s>; Mon, 17 Feb 2003 09:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTBQOMH>; Mon, 17 Feb 2003 09:12:07 -0500
Received: from BELLINI.MIT.EDU ([18.62.3.197]:27421 "EHLO bellini.mit.edu")
	by vger.kernel.org with ESMTP id <S267224AbTBQOKg>;
	Mon, 17 Feb 2003 09:10:36 -0500
From: ghugh Song <ghugh@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Trouble w/ e1000 v4.4.19 for Intel gigabit 82545EM on-board chip. 
Message-Id: <20030217142025.A5BB51AFB4@bellini.mit.edu>
Date: Mon, 17 Feb 2003 09:20:25 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Under SuSE-8.1-CDROM supplied 2.4.19-UP with e1000 v4.3.15 module, this 
ethernet worked on a E7505 based Supermicro X5DA8 Dual Xeon motherboard
with the Intel 82545EM chip on board with no special kernel option
inserted.  The RJ45 is hooked to 100Mb/s speed CISCO switching hub.

Now, e1000 v4.4.19 custom-built 2.4.21-pre4ac4 with SMP enabled does not work.
e1000 is detected.  It appeared properly in ifconfig with its own 
HWaddr.  But it does not work.

For the moment, netgear 100Mb/s card is inserted and enabled by module.
And this one is working right now.


Does anyone have a similar trouble with e1000?

Thanks a lot.

Regards to all the Kernel developers.

G. Hugh Song
