Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283340AbRK2RYv>; Thu, 29 Nov 2001 12:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283339AbRK2RYl>; Thu, 29 Nov 2001 12:24:41 -0500
Received: from Backfire.WH8.TU-Dresden.De ([141.30.225.118]:26755 "EHLO
	backfire.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S283331AbRK2RYY>; Thu, 29 Nov 2001 12:24:24 -0500
Message-Id: <200111291724.fATHOMP4005554@backfire.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=US-ASCII
From: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Organization: Networkadministrator WH8/DD/Germany
To: linux-kernel@vger.kernel.org
Subject: msdos.o and vfat.o doesn't have a valid licence
Date: Thu, 29 Nov 2001 18:24:22 +0100
X-Mailer: KMail [version 1.3.2]
X-PGP-fingerprint: B0FA 69E5 D8AC 02B3 BAEF  E307 BD3A E495 93DD A233
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I just discovered that vfat.o and msdos.o doen't have a licence.

Why?

backfire:~# modprobe vfat
Warning: loading /lib/modules/2.4.16-pre1/kernel/fs/vfat/vfat.o will taint 
the kernel: no license

This warning is bogus because the kernel _is_ already tainted.

-Gregor
