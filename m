Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286337AbRL0Q0c>; Thu, 27 Dec 2001 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286342AbRL0Q0W>; Thu, 27 Dec 2001 11:26:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30212 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286337AbRL0Q0O>; Thu, 27 Dec 2001 11:26:14 -0500
Date: Thu, 27 Dec 2001 08:23:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time Slice Split Scheduler 2nd ...
In-Reply-To: <Pine.LNX.4.40.0112261403500.1549-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0112270823380.2319-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Dec 2001, Davide Libenzi wrote:
>
> This is the second version of the Time Slice Split Scheduler that
> separates the concept of time slice from the concept of dynamic priority.

Looks good to me. Applied.

		Linus

