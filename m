Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBIIWy>; Fri, 9 Feb 2001 03:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129059AbRBIIWp>; Fri, 9 Feb 2001 03:22:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22144 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129030AbRBIIWd>;
	Fri, 9 Feb 2001 03:22:33 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14979.43130.731593.90703@pizda.ninka.net>
Date: Fri, 9 Feb 2001 00:21:14 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] zerocopy patch against 2.4.2-pre2
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As usual:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.2p2-1.diff.gz

It's updated to be against the latest (2.4.2-pre2) and I've removed
the non-zerocopy related fixes from the patch (because I've sent them
under seperate cover to Linus).

Enjoy.  As usual, I am very seriously interested in any bugs or
performance problems introduced by this patch.  Thanks.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
