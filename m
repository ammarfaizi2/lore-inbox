Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272196AbRIOKJZ>; Sat, 15 Sep 2001 06:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272197AbRIOKJE>; Sat, 15 Sep 2001 06:09:04 -0400
Received: from csa.iisc.ernet.in ([144.16.67.8]:20236 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S272196AbRIOKIx>;
	Sat, 15 Sep 2001 06:08:53 -0400
Date: Sat, 15 Sep 2001 15:38:52 +0530 (IST)
From: "M.Gopi Krishna" <mgopi@csa.iisc.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: regarding scsi logging
Message-ID: <Pine.LNX.4.21.0109151534420.6362-100000@ruby.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think i've turned full scsi logging on while compiling the kernel.
Somewhere i read that this can cause infinite loop if the log file also
resides on scsi disk.
Currently i'm testing a new (pseudo) device driver on scsi device driver.
While writing to that device , the use appl hangs though the system is
usable.
Can it be because of above problem, since i find no problem in using the
mounted file system which resides on scsi disk.
Thanks
PS: pl cc the responses to me as i'm not on the group
-- 
mgopi.

