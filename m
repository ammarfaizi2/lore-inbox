Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132277AbRAJBNW>; Tue, 9 Jan 2001 20:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132693AbRAJBNN>; Tue, 9 Jan 2001 20:13:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52617 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132277AbRAJBNI>;
	Tue, 9 Jan 2001 20:13:08 -0500
Date: Tue, 9 Jan 2001 16:55:36 -0800
Message-Id: <200101100055.QAA07674@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: Updated zerocopy patch up on kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nothing interesting or new, just merges up with the latest 2.4.1-pre1
patch from Linus.

ftp.kernel.org:/pub/linux/kernel/people/davem/zerocopy-2.4.1p1-1.diff.gz

I haven't had any reports from anyone, which must mean that it is
working perfectly fine and adds no new bugs, testers are thus in
nirvana and thus have nothing to report.  :-)

As much as I would like to believe this, I know that there must be
some (however minor) bug in there.  So please make the effort to
report bugs if you do spot them.  Again, a reminder to test bugs also
against vanilla 2.4.1pre1 and report the bug against that if the bug
appears there too. This way, I know what bugs are specific to the
zerocopy stuff and which are not.

Thanks.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
