Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289492AbSAWHf2>; Wed, 23 Jan 2002 02:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289702AbSAWHfT>; Wed, 23 Jan 2002 02:35:19 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:57348 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289492AbSAWHfK>; Wed, 23 Jan 2002 02:35:10 -0500
Subject: 2.5.3-pre3 -- aironet4500_core.c:2839:  In function `awc_init':
	incompatible types in return
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 22 Jan 2002 23:34:08 -0800
Message-Id: <1011771248.24309.60.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make[2]: Entering directory `/usr/src/linux/drivers/net'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -DEXPORT_SYMTAB -c aironet4500_core.c
aironet4500_core.c: In function `awc_init':
aironet4500_core.c:2839: incompatible types in return
aironet4500_core.c:2841: warning: control reaches end of non-void function
make[2]: *** [aironet4500_core.o] Error 1

CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=y
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=y
CONFIG_AIRONET4500_CS=m


