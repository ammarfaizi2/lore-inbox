Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbQLQX36>; Sun, 17 Dec 2000 18:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130369AbQLQX3t>; Sun, 17 Dec 2000 18:29:49 -0500
Received: from cmb1-3.dial-up.arnes.si ([194.249.32.3]:7428 "EHLO
	cmb1-3.dial-up.arnes.si") by vger.kernel.org with ESMTP
	id <S129911AbQLQX3b>; Sun, 17 Dec 2000 18:29:31 -0500
From: Igor Mozetic <igor.mozetic@uni-mb.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14909.17707.4868.460585@cmb1-3.dial-up.arnes.si>
Date: Sun, 17 Dec 2000 23:58:51 +0100
To: linux-kernel@vger.kernel.org
Subject: mount and 2.2.18
X-Mailer: VM 6.85 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After installing the latest 2.2.18 kernel on a Debian 2.2 
box the following keeps appearing in kern.log:

Dec 17 18:33:53 xxx kernel: nfs warning: mount version older than kernel

Is this harmless or do I need the latest mount?
Currently I don't use kNFSv3, user-space v2 is fine.

-Igor Mozetic
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
