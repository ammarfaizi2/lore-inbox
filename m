Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286944AbSAMSBR>; Sun, 13 Jan 2002 13:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287332AbSAMSBH>; Sun, 13 Jan 2002 13:01:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:15236 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286944AbSAMSAt>;
	Sun, 13 Jan 2002 13:00:49 -0500
Date: Sun, 13 Jan 2002 20:58:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds <torvalds@transmeta.com>, anton <anton@samba.org>
Subject: Re: [patch] O(1) scheduler, -H7
In-Reply-To: <20020113185732.72ea3aa8.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0201132056360.8784-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 Jan 2002, Stephan von Krawczynski wrote:

> sched.o sched.c sched.c:21: asm/sched.h: No such file or directory

Please re-download the 2.4.17 -H7 patch, i've fixed this.

	Ingo

