Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286751AbRLVJgg>; Sat, 22 Dec 2001 04:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286749AbRLVJgT>; Sat, 22 Dec 2001 04:36:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:32937 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286748AbRLVJgA>;
	Sat, 22 Dec 2001 04:36:00 -0500
Date: Sat, 22 Dec 2001 12:33:33 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] irqrate-2.4.17-A0
Message-ID: <Pine.LNX.4.33.0112221227540.4953-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've uploaded the latest, 2.4.17-A0 IRQ-rate-limiting patch to:

        http://redhat.com/~mingo/irqrate-patches/

this is just a straightforward port to 2.4.17. The patch, while it adds
the dynamic hard-IRQ-limiting feature and fixes softirq performance, it
also removes more lines of code than it adds.

comments, bug reports and suggestions are welcome,

	Ingo

