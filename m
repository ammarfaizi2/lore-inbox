Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbQKGGS0>; Tue, 7 Nov 2000 01:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129645AbQKGGSR>; Tue, 7 Nov 2000 01:18:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10114 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129116AbQKGGSB>;
	Tue, 7 Nov 2000 01:18:01 -0500
Date: Mon, 6 Nov 2000 22:03:05 -0800
Message-Id: <200011070603.WAA02292@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jordy@napster.com
CC: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <3A079D83.2B46A8FD@napster.com> (message from Jordan Mendelson on
	Mon, 06 Nov 2000 22:13:23 -0800)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 06 Nov 2000 22:13:23 -0800
   From: Jordan Mendelson <jordy@napster.com>

   There is a possibility that we are hitting an upper level bandwidth
   limit between us an our upstream provider due to a misconfiguration
   on the other end, but this should only happen during peak time
   (which it is not right now). It just bugs me that 2.2.16 doesn't
   appear to have this problem.

The only thing I can do now is beg for a tcpdump from the windows95
machine side.  Do you have the facilities necessary to obtain this?
This would prove that it is packet drop between the two systems, for
whatever reason, that is causing this.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
