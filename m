Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132779AbQLRDim>; Sun, 17 Dec 2000 22:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132886AbQLRDib>; Sun, 17 Dec 2000 22:38:31 -0500
Received: from mtiwmhc26.worldnet.att.net ([204.127.131.51]:18888 "EHLO
	mtiwmhc26.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S132779AbQLRDiP>; Sun, 17 Dec 2000 22:38:15 -0500
Date: Sun, 17 Dec 2000 22:08:51 -0500
From: khromy <khromy@lnuxlab.net>
To: linux-kernel@vger.kernel.org
Subject: unresolved symbols pm_*register ad1848.o
Message-ID: <20001217220851.A37686@lnuxlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-test13-pre3 unresolved symbols:

modprobe ad1848
/lib/modules/2.4.0-test13-pre3/kernel/drivers/sound/ad1848.o: unresolved symbol pm_unregister_Reccd1e64
/lib/modules/2.4.0-test13-pre3/kernel/drivers/sound/ad1848.o: unresolved symbol pm_register_R8dbab11c
/lib/modules/2.4.0-test13-pre3/kernel/drivers/sound/ad1848.o: insmod /lib/modules/2.4.0-test13-pre3/kernel/drivers/sound/ad1848.o failed
-- 
L1:	khromy		;khromy(at)lnuxlab.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
