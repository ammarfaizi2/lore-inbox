Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317686AbSGVOLQ>; Mon, 22 Jul 2002 10:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317695AbSGVOLQ>; Mon, 22 Jul 2002 10:11:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4254 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317686AbSGVOLP>;
	Mon, 22 Jul 2002 10:11:15 -0400
Date: Mon, 22 Jul 2002 16:13:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] big IRQ lock removal, 2.5.27-D7
Message-ID: <Pine.LNX.4.44.0207221611560.10236-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


next iteration:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-D7

Changes:

 - plip.c, 8139too.c and 8139cp.c fixes from Muli Ben-Yehuda

	Ingo

