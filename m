Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262860AbSJAVTy>; Tue, 1 Oct 2002 17:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262861AbSJAVTy>; Tue, 1 Oct 2002 17:19:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38346 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262860AbSJAVTy>;
	Tue, 1 Oct 2002 17:19:54 -0400
Date: Tue, 1 Oct 2002 23:35:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <m3bs6dn9x6.fsf@trained-monkey.org>
Message-ID: <Pine.LNX.4.44.0210012332130.25070-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Oct 2002, Jes Sorensen wrote:

> The point here is that it probably makes the code easier for you to
> read, but it makes it harder for a lot of other people since it's
> inconsistent with the standard. [...]

i began the whole line of argument with this sentence:

> *If* the consistent convention were to use the _t postfix for complex
> 'derived' types, it would create more compact and more readable kernel
> code.

furthermore:

> I agree that consistency is more important than having the absolute best
> rules, [...]

so i think we are in violent agreement regarding consistency.

	Ingo

