Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRIFDA3>; Wed, 5 Sep 2001 23:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271017AbRIFDAU>; Wed, 5 Sep 2001 23:00:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49352 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270774AbRIFDAK>;
	Wed, 5 Sep 2001 23:00:10 -0400
Date: Wed, 05 Sep 2001 20:00:29 -0700 (PDT)
Message-Id: <20010905.200029.125542136.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: [UPDATE] PCI64 updates/fixes
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ I'm leaving for a week in Europe tomorrow afternoon, so it's
  best to defer directly sent patches and commentary until next
  Thursday when I return. ]

Obtain it from:

ftp.kernel.org:/pub/linux/kernel/people/davem/PCI64/pci64-2.4.10p4-1.patch.gz

New in this release:

1) Alpha patch garbled in previous release (me)
2) Alpha build fixes and cleanups (Richard Henderson)
3) Merge to 2.4.10-pre4 (me)

It would be nice if someone would do the bits for ia64 and other ports
while I am away.  ia64 in particular should require a very small
amount of work.

Jens should be making new highmem-nobounce patches based upon this
soon.

Later,
David S. Miller
davem@redhat.com
