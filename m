Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVI0Nym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVI0Nym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVI0Nym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:54:42 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:38132 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964947AbVI0Nyl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:54:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WScgDMI9qF+piEJLPlR32qVo5uR/LkM1ou3/mFegAsu7XSoaDbJFt3YsoS0o2ZZEDurpgRHBNK94YTKBW3XtoNQgAvugsUcKTEkvfA4T8I/KB35rr46Vc1uJuDkLDekb43rjNnD3iRxFpHzYcqWGiEdIp2eKVlIYz3YCMeCNkFo=
Message-ID: <b490b95105092706546594d41b@mail.gmail.com>
Date: Tue, 27 Sep 2005 14:54:40 +0100
From: Carlos Cunha <cunhacn@gmail.com>
Reply-To: Carlos Cunha <cunhacn@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [Help] Kernel Panic not syncing: drivers/ide/pci/piix.c:390
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

A friend of mine has a Toshiba Satellite M35X-S163 and have got RedHat
Linux ES(2.6.9-5.EL). Everytime he boots his computer hangs and shows
the following info:

Booting Red Hat Linux ES (2.6.9-5.EL)
root (hd0,4)
  Filesystem type is ext2fs, partition type 0x83

Kernel /boot/vmlinuz-2.6.9-5.EL ro root=LABEL=/ rhgb quiet
   [Linux-b2Image, setup=0x1400, Size=0x15ab84]

initrd /boot/initrd-2.6.9-5.EL.img
   [Linux-initrd @ 0x1dc6f000, 0x60592 bytes]

Uncompression Linux.... OK, booting the Kernel
   audit(1127830961 506:0): initialized

Kernel panic-not syncing: drivers/ide/pci/piix.c:390:
   spin_lock(drivers/ide/ide.c:c036b8e8) already locked by
      drivers/ide/ide-iops.c/1234

-----------
If you have an idea on how to help it is greatly appreciated.

Carlos
