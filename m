Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129895AbQKINji>; Thu, 9 Nov 2000 08:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129809AbQKINj3>; Thu, 9 Nov 2000 08:39:29 -0500
Received: from [193.120.224.170] ([193.120.224.170]:63637 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129787AbQKINjO>;
	Thu, 9 Nov 2000 08:39:14 -0500
Date: Thu, 9 Nov 2000 13:39:04 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Christoph Rohland <cr@sap.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <3A0A9E33.F268D4C5@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.21.0011091332080.7475-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Michael Rothwell wrote:

> Well, then, problem solved.
> 

:)

> > afaik linus allows binary modules in most cases.
> 
> And since an "Advanced Linux Kernel Project" wouldn't be a Linus kernel,
> what then? Would they have the same discretion as Linus? Would Linus'
> exception apply to them?

don't know. you'd have to ask him...

I actually think Linus has been too loose/vague on modules. The
official COPYING txt file in the tree contains an exception on linking
to the kernel using syscalls from linus and the GPL. nothing about
binary modules, and afaik the only statements he's ever made about
binary modules were off the cuff on l-k a long time (unless someone
knows a binary module whose vendor can show a written exception from
Linus et al). 

The result of all this is that we've had plenty of vendors ignoring
the GPL as it applies to linux and release binary modules all because
linus said on a mailling list that he doesn't mind too much. not a
very strong affirmation of the conditions under which linux is
licensed.

be nice if the binary module thing could be clarified by the copyright
holders.

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
