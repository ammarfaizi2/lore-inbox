Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbSKQUWJ>; Sun, 17 Nov 2002 15:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267585AbSKQUWJ>; Sun, 17 Nov 2002 15:22:09 -0500
Received: from mx1.elte.hu ([157.181.1.137]:14773 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267583AbSKQUWI>;
	Sun, 17 Nov 2002 15:22:08 -0500
Date: Sun, 17 Nov 2002 22:45:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <1037564166.1597.119.camel@ldb>
Message-ID: <Pine.LNX.4.44.0211172243360.19793-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Nov 2002, Luca Barbieri wrote:

> No, but since I don't see any advantage in breaking it (other than a
> more aesthetically pleasing header), why break it? The problem is just
> the numbering of the flags, not the new functionality.

tiny bits of aesthetics, like clean ordering of the flag values, is what
makes for a clean and easy to understand source tree. Lets do it while we
can do it.

	Ingo

