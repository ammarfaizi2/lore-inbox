Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAJDQE>; Tue, 9 Jan 2001 22:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRAJDPy>; Tue, 9 Jan 2001 22:15:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2699 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129764AbRAJDPf>;
	Tue, 9 Jan 2001 22:15:35 -0500
Date: Tue, 9 Jan 2001 18:58:07 -0800
Message-Id: <200101100258.SAA16505@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: dean-list-linux-kernel@arctic.org
CC: mingo@elte.hu, riel@conectiva.com.br, hch@caldera.de, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101091826200.10428-100000@twinlark.arctic.org>
	(message from dean gaudet on Tue, 9 Jan 2001 18:56:33 -0800 (PST))
Subject: Re: storage over IP (was Re: [PLEASE-TESTME] Zerocopy networking patch,
 2.4.0-1)
In-Reply-To: <Pine.LNX.4.30.0101091826200.10428-100000@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 9 Jan 2001 18:56:33 -0800 (PST)
   From: dean gaudet <dean-list-linux-kernel@arctic.org>

   is NFS receive single copy today?

With the zerocopy patches, NFS client receive is "single cpu copy" if
that's what you mean.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
