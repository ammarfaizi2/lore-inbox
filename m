Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbRA2IVk>; Mon, 29 Jan 2001 03:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130281AbRA2IVa>; Mon, 29 Jan 2001 03:21:30 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:35597 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129874AbRA2IVU>;
	Mon, 29 Jan 2001 03:21:20 -0500
Message-ID: <3A75289F.FF6C9B78@snowbird.megapath.net>
Date: Mon, 29 Jan 2001 00:23:59 -0800
From: Miles Lane <miles@snowbird.megapath.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre11 -- Unresolved symbols in smctr.o and comx.o (fixed in Alan's 
 tree).
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Do you plan to take a patch from Alan that fixes this for 2.4.1?

depmod: *** Unresolved symbols in
/lib/modules/2.4.1-pre11/kernel/drivers/net/tokenring/smctr.o
depmod: 	__bad_udelay
depmod: *** Unresolved symbols in
/lib/modules/2.4.1-pre11/kernel/drivers/net/wan/comx.o
depmod: 	proc_get_inode
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
