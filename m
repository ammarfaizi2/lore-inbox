Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSGJHER>; Wed, 10 Jul 2002 03:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSGJHEQ>; Wed, 10 Jul 2002 03:04:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30873 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317491AbSGJHEP>;
	Wed, 10 Jul 2002 03:04:15 -0400
Date: Thu, 11 Jul 2002 09:05:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "Kevin O'Connor" <kevin@koconnor.net>
Subject: [patch] Re: O(1) batch scheduler
In-Reply-To: <20020709223021.A4567@arizona.localdomain>
Message-ID: <Pine.LNX.4.44.0207110842520.3580-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you can find my latest scheduler tree, against 2.5.25-vanilla, at:

        http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.25-A7

note that in addition to the bugfix i've further simplified the
idle-average calculation - simple, weightless running average is
more than enough.

	Ingo

