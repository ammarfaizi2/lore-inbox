Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286557AbSABBlm>; Tue, 1 Jan 2002 20:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286574AbSABBlW>; Tue, 1 Jan 2002 20:41:22 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:63951 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286557AbSABBlU>; Tue, 1 Jan 2002 20:41:20 -0500
Date: Tue, 1 Jan 2002 18:41:13 -0700
Message-Id: <200201020141.g021fDT19909@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Larry McVoy <lm@bitmover.com>, Oliver Xymoron <oxymoron@waste.org>,
        samson swanson <intellectcrew@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: a great C++ book?
In-Reply-To: <20020102014233.C5968@werewolf.able.es>
In-Reply-To: <20020101041111.29695.qmail@web14310.mail.yahoo.com>
	<Pine.LNX.4.43.0201011214560.7188-100000@waste.org>
	<20020101104331.F4802@work.bitmover.com>
	<200201012001.g01K1NF15702@vindaloo.ras.ucalgary.ca>
	<20020102014233.C5968@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. A. Magallon writes:
> 
> On 20020101 Richard Gooch wrote:
> >
> >Object-oriented programming is a good tool. One of many. But it
> >shouldn't be a religion, nor do you need to write in C++ to make use
> 
> Use the right tool for the purpose. You bet for rewriting half the
> C++ runtime in C instead of not-using the bloated part of C++.
> Pretty. If you're going to program in a OO way, use an oo language.
> And I get tired of people saying C++ is bloat.

Actually, I didn't say that C++ is bloat. I said C++ makes "it much
easier to write bloatware". Big difference.

> My pupils at 5th course of Computer Science still think C++ is
> bloat.

Good. That means they'll approach it with caution, rather than jumping
on the bandwagon.

> They have no idea on compilers. And they bless Ada.  A 5th level
> virtual function still has only a one-level indirection overhead
> when called. Low level code is just as efficient as C. If a C++
> program is bloated it is the programmers matter, not the language.

Not when the language seduces you into writing bloatware. The more
powerful the language and the more abstract the concepts it supports,
the further the programmer is taken away from understanding what's
happening at the low level. That leads to bloatware.

If I had my way, no CS student would graduate unless they understood
what's happening at the low level and had experience benchmarking and
optimising code. A good start would be to have at least one assignment
where they have to write a reasonably complex piece of code, in any
language, and their marks are based on how fast the code runs. And the
marks should be scaled down if everyone writes code which is much
slower than the instructor's.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
