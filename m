Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273526AbRIUNaB>; Fri, 21 Sep 2001 09:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273529AbRIUN3v>; Fri, 21 Sep 2001 09:29:51 -0400
Received: from hermes.domdv.de ([193.102.202.1]:1541 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S273526AbRIUN3d>;
	Fri, 21 Sep 2001 09:29:33 -0400
Message-ID: <XFMail.20010921152927.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Fri, 21 Sep 2001 15:29:27 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-pre13: Panic mounting initrd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cut and paste via paper clipboard:


RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1850k freed
read_super_block: can't find a reiserfs filesystem on (dev 01:00, block 64,
size 1024)
read_super_block: can't find a reiserfs filesystem on (dev 01:00, block 8, size
1024)
Kernel panic: VFS: Unable to mount root fs on 01:00


My initrd is ext2 formatted.
2.4.10-pre12 works, 2.4.10-pre13 compiled with same kernel config as pre12.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
