Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319039AbSHMThB>; Tue, 13 Aug 2002 15:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319057AbSHMThB>; Tue, 13 Aug 2002 15:37:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28129 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319039AbSHMThA>;
	Tue, 13 Aug 2002 15:37:00 -0400
Date: Tue, 13 Aug 2002 21:41:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] CLONE_SETTLS, CLONE_SETTID, 2.5.31-BK
In-Reply-To: <Pine.LNX.4.44.0208131239271.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132140160.8918-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> It's still buggy, and you didn't read what I wrote.

yeah - paperbag time.

> Notice how your testing did not find it, since you always just set both
> flags.

yes, the test used the old single CLONE_STARTUP flag.

	Ingo

