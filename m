Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSIIGpa>; Mon, 9 Sep 2002 02:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSIIGp3>; Mon, 9 Sep 2002 02:45:29 -0400
Received: from [212.3.242.3] ([212.3.242.3]:1013 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S316542AbSIIGp3>;
	Mon, 9 Sep 2002 02:45:29 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: linux 2.4.20-ac patches
Date: Mon, 9 Sep 2002 08:47:32 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209090847.32334.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since my recent harddisk problems I had to reinstall my entire linux. 
The only hardware change in the system is that the two harddisks have been 
swapped on the ide cable (jumpers have been changed accordingly).

Since then if I ever attempt to access the cdrom (which is used through 
/dev/sr1 using ide-scsi) i get an oops. After that, I get errors from the 
SCSI layer talking about timeouts and retries.

I've since then switched back to vanilla 2.4.19 which works fine with me. The 
-ac patches don't.

Before the harddiskproblems it worked correctly.

I'll see this eve to cause, ksymoops and send in an oops.
-- 
Bacchus, n.:
	A convenient deity invented by the ancients as an excuse for
getting drunk.
		-- Ambrose Bierce, "The Devil's Dictionary"

