Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282997AbRK1BDL>; Tue, 27 Nov 2001 20:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281839AbRK1BDA>; Tue, 27 Nov 2001 20:03:00 -0500
Received: from pain.mizi.com ([203.239.30.128]:39554 "EHLO pain.mizi.com")
	by vger.kernel.org with ESMTP id <S281840AbRK1BCs>;
	Tue, 27 Nov 2001 20:02:48 -0500
Date: Wed, 28 Nov 2001 10:02:55 +0900 (KST)
From: Chung Won-young <suni00@mizi.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.1-pre2 Unresolved symbols ...
Message-ID: <Pine.LNX.4.33.0111280951220.8854-100000@pain.mizi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=euc-kr
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just compiled 2.5.1-pre2, and during "make modules_install":

depmod: *** Unresolved symbols in /lib/modules/2.5.1-pre2/kernel/drivers/ide/ide-floppy.o
depmod:         ide_revalidate_drive
depmod: *** Unresolved symbols in /lib/modules/2.5.1-pre2/kernel/fs/nfs/nfs.o
depmod:         seq_escape
depmod:         seq_printf


-- 
- ∆Û¿Œ -

Chung Won-young     suni00@kernel.pe.kr, suni00@mizi.com
MIZI Research, Inc. Embedded Team
http://kernel.pe.kr ICQ:36602496

