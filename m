Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130205AbRBCQ4z>; Sat, 3 Feb 2001 11:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129979AbRBCQ4q>; Sat, 3 Feb 2001 11:56:46 -0500
Received: from chiara.elte.hu ([157.181.150.200]:4104 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130152AbRBCQ4f>;
	Sat, 3 Feb 2001 11:56:35 -0500
Date: Sat, 3 Feb 2001 17:54:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
        <linux-net@vger.kernel.org>
Subject: [patch] Zerocopy 2.4.1 rev3 patch against 2.4.1-ac2
In-Reply-To: <14971.45502.776808.711822@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0102031751150.1628-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2001, David S. Miller wrote:

> Some people have asked me about making a patch against the AC patches.
> It is doable, but would be quite a bit of work for me.

i've done this for TUX anyway, so here is the 2.4.1-rev3 patch against the
2.4.1-ac2 tree:

    http://people.redhat.com/mingo/davem-zerocopy-patches/zerocopy-2.4.1-ac2-A0.bz2

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
