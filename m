Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319085AbSHSWjn>; Mon, 19 Aug 2002 18:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319086AbSHSWjm>; Mon, 19 Aug 2002 18:39:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52679 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319085AbSHSWjQ>;
	Mon, 19 Aug 2002 18:39:16 -0400
Date: Tue, 20 Aug 2002 00:44:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <1029796863.942.1.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208200043340.5439-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19 Aug 2002, Robert Love wrote:

> So are you saying we can never deprecate interfaces, just so you can
> continue using libc5?
> 
> Seems saner to keep libc5 in sync with the kernel than vice versa..

put differently: if you insist on using libc5 (and its tons of security
holes) then you might as well use an older kernel such as 2.4 or 2.6.

	Ingo

