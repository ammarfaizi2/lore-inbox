Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSFDSVl>; Tue, 4 Jun 2002 14:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSFDSVk>; Tue, 4 Jun 2002 14:21:40 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:23302 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315445AbSFDSVi>; Tue, 4 Jun 2002 14:21:38 -0400
Subject: 2.5.20-dj2 -- fdomain_stub.c:98: unknown field `abort' specified in
	initializer
From: Miles Lane <miles@megapathdsl.net>
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Jun 2002 11:42:18 -0700
Message-Id: <1023216140.20264.29.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DKBUILD_BASENAME=fdomain_stub  -c -o fdomain_stub.o fdomain_stub.c
fdomain_stub.c:98: unknown field `abort' specified in initializer
fdomain_stub.c:98: warning: initialization from incompatible pointer type
fdomain_stub.c:98: unknown field `reset' specified in initializer
fdomain_stub.c:98: warning: initialization from incompatible pointer type
make[3]: *** [fdomain_stub.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5/drivers/scsi/pcmcia'


