Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279982AbRKDQC3>; Sun, 4 Nov 2001 11:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280016AbRKDQCU>; Sun, 4 Nov 2001 11:02:20 -0500
Received: from jabberwock.ucw.cz ([212.71.128.53]:8713 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S279982AbRKDQCI>;
	Sun, 4 Nov 2001 11:02:08 -0500
Date: Sun, 4 Nov 2001 17:02:02 +0100
From: Martin Mares <mj@ucw.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: The PCI ID Repository
Message-ID: <20011104170202.A3370@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, world!\n

I've created a public repository for PCI ID's to avoid the long delays
caused by me being unable to cope with the flood of ID updates I was
receiving.

The repository lives at http://pciids.sourceforge.net/ and you can download
the daily snapshots of pci.ids, browse the ID lists interactively and also
submit new entries via Web forms. Alternatively, you can mail your submissions
as unified diffs (no base64 encoded attachments, please) to pci-ids@ucw.cz
where they get processed by an e-mail robot and also automatically added
to the database, awaiting approval by one of the maintainers.

So share and enjoy and submit your ID's.

(There is still a part of my e-mail backlog unprocessed, so don't worry,
I'll send it to the mailbot soon.)

Also, I've released a new version of pciutils containing a pci.ids file
synchronized with the repository and sent a patch to Linus which will
get the kernel in sync as well.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Dijkstra probably hates me." -- /usr/src/linux/kernel/sched.c
