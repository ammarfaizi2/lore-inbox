Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSGVSNb>; Mon, 22 Jul 2002 14:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317766AbSGVSNb>; Mon, 22 Jul 2002 14:13:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43955 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317836AbSGVSNa>;
	Mon, 22 Jul 2002 14:13:30 -0400
Date: Mon, 22 Jul 2002 20:15:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] big IRQ lock removal, 2.5.27-E0
Message-ID: <Pine.LNX.4.44.0207222013040.19989-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


adopted the 'misc irqlock fixes and updates' patch to the
cli-sti-cleanup-A2 patch:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-E0

compiles, boots, works just fine.

	Ingo

