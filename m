Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUFEShW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUFEShW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 14:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUFEShW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 14:37:22 -0400
Received: from mail.tmr.com ([216.238.38.203]:2944 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S261793AbUFEShW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 14:37:22 -0400
Date: Sat, 5 Jun 2004 14:36:20 -0400
From: root <root@pixels.tmr.com>
Message-Id: <200406051836.i55IaKH3011610@pixels.tmr.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.7-rc2] module build fails
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make install
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
Kernel: arch/i386/boot/bzImage is ready
sh /usr/src/linux-2.6.7-rc2/arch/i386/boot/install.sh 2.6.7-rc2-bk2 arch/i386/boot/bzImage System.map ""
WARNING: /lib/modules/2.6.7-rc2-bk2/kernel/drivers/media/dvb/frontends/tda1004x.ko needs unknown symbol errno
pixels:root>
