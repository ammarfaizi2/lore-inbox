Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131352AbRDIBqC>; Sun, 8 Apr 2001 21:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132592AbRDIBpw>; Sun, 8 Apr 2001 21:45:52 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:45068 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S131352AbRDIBpl>; Sun, 8 Apr 2001 21:45:41 -0400
Date: Mon, 9 Apr 2001 09:46:15 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Subject: 2.4.4-pre1 Unresolved symbols "strstr"
Message-ID: <Pine.LNX.4.33.0104090940520.5815-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


depmod version 2.4.5


Compiled 2.4.4-pre1 but running "depmod" generates a lot of these ...

depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre1/kernel/drivers/char/ltmodem.o
depmod:         strstr
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre1/kernel/drivers/char/serial.o
depmod:         strstr
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-cd.o
depmod:         strstr
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-mod.o
depmod:         strstr
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-probe-mod.o
depmod:         strstr
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre1/pcmcia/xirc2ps_cs.o
depmod:         strstr


Thanks,
Jeff
[ jchua@fedex.com ]

