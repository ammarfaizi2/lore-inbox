Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbRAZIIE>; Fri, 26 Jan 2001 03:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbRAZIHx>; Fri, 26 Jan 2001 03:07:53 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:1035 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S130147AbRAZIHi>;
	Fri, 26 Jan 2001 03:07:38 -0500
Message-ID: <3A7130EE.E314F4A5@megapathdsl.net>
Date: Fri, 26 Jan 2001 00:10:22 -0800
From: Miles Lane <miles@megapathdsl.net>
Reply-To: miles@megapathdsl.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-pre10 -- Unresolved symbols in smctr.o and comx.o
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/lib/modules/2.4.1-pre10/kernel/drivers/net/tokenring/smctr.o
depmod: 	__bad_udelay
depmod: *** Unresolved symbols in
/lib/modules/2.4.1-pre10/kernel/drivers/net/wan/comx.o
depmod: 	proc_get_inode

If you need more info, just ask.

	Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
