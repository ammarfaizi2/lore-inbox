Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311170AbSCHV73>; Fri, 8 Mar 2002 16:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311161AbSCHV7U>; Fri, 8 Mar 2002 16:59:20 -0500
Received: from zeke.inet.com ([199.171.211.198]:44176 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S311168AbSCHV7O>;
	Fri, 8 Mar 2002 16:59:14 -0500
Message-ID: <3C893429.2020406@inet.com>
Date: Fri, 08 Mar 2002 15:59:05 -0600
From: Eli <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Jonathan A. George" <JGeorge@greshamstorage.com>
CC: Dave Jones <davej@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com> <20020308021909.L29587@suse.de> <3C891EA4.6090102@greshamstorage.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan A. George wrote:
 >  My respect for BK is certainly been enhanced by this
> discussion, but I still would prefer a free (or failing that GPL) 
> license. ;-)
> 
> Comments?

A comment/request.
Take your list of requirements and see how each system "we" (as in 
kernel hackers) use stacks up and post that to the list.

Be sure to include ARCH, Bitkeeper, CVS, diff&patch, emacs, SCCS, 
Subversion, and any others I've missed... I don't know what all the 
options are, and that is something that would be useful to know.
(Also, consider "bundles" such as CVS+cervisia+tkdiff or something).
The list should have comments about each rather than just a checklist, 
so you give an idea of quality of implementations as well.
Actually, Larry McVoy might have such a compilation in his sales 
materials, or should. ;)

Also, you didn't mention Subversion, which is a Free license, and has 
many of the same stated goals as you have.  There is some decent 
documentation on their design and some discussion about _why_ they made 
their choices.  That should be worth-while reading regardless of the 
path you choose to pursue.  You might consider that if Subversion does 
half of your goals it might be easier to add to it than start from CVS 
or from scratch...

Comments?

Eli
disclaimer: I use CVS because it is what I know and it is available 
"everywhere".  I'm planning to use Subversion at some future date. 
Plans subject to change based upon additional knowledge, partly from 
this list. *shrug*
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

