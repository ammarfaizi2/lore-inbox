Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286491AbRL0TCS>; Thu, 27 Dec 2001 14:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286477AbRL0TCI>; Thu, 27 Dec 2001 14:02:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45832 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286504AbRL0TBy>; Thu, 27 Dec 2001 14:01:54 -0500
Date: Thu, 27 Dec 2001 10:59:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time Slice Split Scheduler 2nd ...
In-Reply-To: <Pine.LNX.4.40.0112271026540.1558-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0112271058570.1052-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Dec 2001, Davide Libenzi wrote:
>
> two solutions :
>
> 1) you wait to apply that i'll collect statistical dyn_prio data and i'll
> 	tune the PROC_CHANGE_PENALTY values
>
> 2) i'll post a subsequent patch to fix that

I much prefer (2) - especially in a development kernel.

		Linus

