Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbTLFVmw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 16:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbTLFVmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 16:42:52 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:37337 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265253AbTLFVmu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 16:42:50 -0500
Date: Sat, 6 Dec 2003 13:42:45 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Schwartz <davids@webmaster.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Larry McVoy <lm@bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206214245.GA18663@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Schwartz <davids@webmaster.com>,
	Theodore Ts'o <tytso@mit.edu>, Larry McVoy <lm@bitmover.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031206153845.GA8552@thunk.org> <MDEHLPKNGKAHNMBLJOLKAEDLIIAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEDLIIAA.davids@webmaster.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 01:30:39PM -0800, David Schwartz wrote:
> 
> > So trust me, you really don't want to claim that just because a
> > program was written to use a particular interface, the license infects
> > across the API.  Apple and Microsoft are playing that game, and a very
> > unsavory game it is.  And it leads to all sorts of paradoxes, such as
> > the one I described above.
> >
> > 						- Ted
> 
> 	What you want do is claim that taking from a copyrighted work merely what
> you need to take from it in order to make your own code interoperate with it
> is fair use. If people honestly believe in free software, they should be
> making these types of claims.

I agree with David.  The GPL isn't free software it is "open" software,
it wants all the changes to be done out in the open.  Which is perfectly
fine, one can look at the BSD history and the Linux history and argue that
the GPL is what made Linux the "winner".  But GPLed software isn't free, it
is software with an agenda, a noble agenda in many opinions (including mine),
of allowing everyone to benefit from the work and enhancements of the work.

Not everyone likes this, however.  The BK license took a lot of heat for the
fact that we reserved the right to force your repositories out in the open
(because it became clear that some people were using the BK commercially and
not paying license fees).  Even though we were saying "it's free if you are
working out in the open" some free software developers felt that was too 
much (it occurs to me as I'm writing this that what the license should say
is that we can force you to open the repos if and only if the changes have
been pulled to another repo - that would finess security feature problem).
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
