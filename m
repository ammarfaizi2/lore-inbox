Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271827AbTHDPsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271831AbTHDPst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:48:49 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:37508 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271827AbTHDPso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:48:44 -0400
From: Miles Lane <miles.lane@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-bk3 (linus' tree) -- drivers/net/3c59x.c:534: error: `WNOOXCVR_PWR' undeclared here (not in a function)
Date: Mon, 4 Aug 2003 08:48:41 -0700
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308040848.41908.miles.lane@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  drivers/net/3c59x.o
drivers/net/3c59x.c:534: error: `WNOOXCVR_PWR' undeclared here (not in a
function)
drivers/net/3c59x.c:534: error: initializer element is not constant
drivers/net/3c59x.c:534: error: (near initialization for
`vortex_info_tbl[23].drv_flags')
drivers/net/3c59x.c:534: error: initializer element is not constant
drivers/net/3c59x.c:534: error: (near initialization for
`vortex_info_tbl[23]')
drivers/net/3c59x.c:536: error: initializer element is not constant
drivers/net/3c59x.c:536: error: (near initialization for
`vortex_info_tbl[24]')
drivers/net/3c59x.c:539: error: initializer element is not constant

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11x
e2fsprogs              1.32
pcmcia-cs              3.2.3
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
GNU ld version 2.14 20030612

CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y

#
# IBM 4xx options
#
CONFIG_PM=y
# CONFIG_8260 is not set
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_MULTIPLATFORM=y
CONFIG_PPC_CHRP=y
CONFIG_PPC_PMAC=y
CONFIG_PPC_PREP=y
CONFIG_PPC_OF=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_ALTIVEC=y

CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_OAKNET is not set
# CONFIG_HAPPYMEAL is not set
CONFIG_SUNGEM=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
