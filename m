Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbQKGW2Y>; Tue, 7 Nov 2000 17:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQKGW2N>; Tue, 7 Nov 2000 17:28:13 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:31886 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S129189AbQKGW2C>;
	Tue, 7 Nov 2000 17:28:02 -0500
Date: Tue, 7 Nov 2000 23:28:14 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Stange NFS messages - 2.2.18pre19
Message-ID: <Pine.LNX.4.10.10011072326340.21756-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm getting this under moderate NFS load:
Nov  6 17:39:56 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  6 17:40:08 iq kernel: svc: unknown program 100227 (me 100003)
Nov  6 19:06:11 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  6 19:38:48 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  6 19:54:51 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  6 20:08:53 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  6 20:53:23 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  7 09:03:28 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  7 09:15:18 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  7 11:12:51 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  7 18:01:17 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  7 19:34:59 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  7 19:40:59 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)
Nov  7 21:43:48 iq kernel: svc: server socket destroy delayed (sk_inuse:
1)

What do these means? Is this a kernel bug?

--  SaPE

Peter, Sasi <sape@sch.hu>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
