Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268229AbTCFSHt>; Thu, 6 Mar 2003 13:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbTCFSHt>; Thu, 6 Mar 2003 13:07:49 -0500
Received: from mx1.elte.hu ([157.181.1.137]:13498 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268229AbTCFSHs>;
	Thu, 6 Mar 2003 13:07:48 -0500
Date: Thu, 6 Mar 2003 19:18:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Levon <levon@movementarian.org>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303061003110.7720-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303061916190.16784-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in any case, i'm quite confortable about your patch now, because it just
fits into the thinking that is behind the current boosting concept. So
it's not a random tweak added here or there (like the iopl() boost), it's
an extension of the core interactivity concept, and as such it cannot have
bad effects, unless the core concept is faulty. (which i dont think it
is.)

	Ingo

