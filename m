Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADBB5>; Wed, 3 Jan 2001 20:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbRADBBq>; Wed, 3 Jan 2001 20:01:46 -0500
Received: from anime.net ([63.172.78.150]:25874 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129324AbRADBBb>;
	Wed, 3 Jan 2001 20:01:31 -0500
Date: Wed, 3 Jan 2001 17:01:27 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Gerhard Mack <gmack@innerfire.net>
cc: Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, <mark@itsolve.co.uk>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.10.10101031624070.2894-100000@innerfire.net>
Message-ID: <Pine.LNX.4.30.0101031657320.1616-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Gerhard Mack wrote:
> On Wed, 3 Jan 2001, Dan Hollis wrote:
> > On Wed, 3 Jan 2001, Gerhard Mack wrote:
> > > Your comparing actual security with stack guarding? Stack guarding mearly
> > > makes the attack diffrent.. rootkits are already available to defeat it.
> > url?
> Ugh do you have any idea how hard it is to find 2 year old exploits?
> Heres the best I could find on short notice:
> http://www.insecure.org/sploits/non-executable.stack.problems.html
> http://darwin.bio.uci.edu/~mcoogan/bugtraq/msg00335.html

You said there were rootkits specifically targetting stackguard.

These URLs simply describe attacks on stackguard, where are the
stackguard rootkits?

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
