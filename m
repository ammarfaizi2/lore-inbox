Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRADBYA>; Wed, 3 Jan 2001 20:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132357AbRADBXv>; Wed, 3 Jan 2001 20:23:51 -0500
Received: from zeus.kernel.org ([209.10.41.242]:15631 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132282AbRADBXl>;
	Wed, 3 Jan 2001 20:23:41 -0500
Date: Wed, 3 Jan 2001 16:34:25 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Dan Hollis <goemon@anime.net>
cc: Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.30.0101031557270.981-100000@anime.net>
Message-ID: <Pine.LNX.4.10.10101031624070.2894-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Dan Hollis wrote:

> On Wed, 3 Jan 2001, Gerhard Mack wrote:
> > Your comparing actual security with stack guarding? Stack guarding mearly
> > makes the attack diffrent.. rootkits are already available to defeat it.
> 
> url?

Ugh do you have any idea how hard it is to find 2 year old exploits?

Heres the best I could find on short notice:

http://www.insecure.org/sploits/non-executable.stack.problems.html
http://darwin.bio.uci.edu/~mcoogan/bugtraq/msg00335.html

 
--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
