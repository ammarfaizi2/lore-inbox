Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbREYSbE>; Fri, 25 May 2001 14:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbREYSay>; Fri, 25 May 2001 14:30:54 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:34382
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S261488AbREYSal>; Fri, 25 May 2001 14:30:41 -0400
Date: Fri, 25 May 2001 11:30:38 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: dledford@redhat.com, aaronl@vitelus.com, acahalan@cs.uml.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Message-ID: <20010525113038.C3225@work.bitmover.com>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>,
	dledford@redhat.com, aaronl@vitelus.com, acahalan@cs.uml.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <200105251702.KAA23819@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200105251702.KAA23819@adam.yggdrasil.com>; from adam@yggdrasil.com on Fri, May 25, 2001 at 10:02:08AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 10:02:08AM -0700, Adam J. Richter wrote:
> 	If you want to argue that a court will use a different definition
> of aggregation, then please explain why and quote that definition.  Also,
> it's important not to forget the word "mere."  If the combination is anything
> *more* than aggregration, then it's not _merely_ aggregation.  So,
> if you wanted to argue from the definition on webster.com:

Adam, the point is not what the GPL says or what the definition is.
The point is "what is legal".  You can, for example, write a license
which says

	By running the software covered by this license, you agree to 
	become my personal slave and you will be obligated to bring
	me coffee each morning for the rest of my life, greating
	me with a "Good morning, master, here is your coffee oh
	most magnificent one".

If anyone is stupid enough to obey such a license, they need help.
The problem is that licenses can write whatever they want, but what they
say only has meaning if it is enforceable.  The "license" above would
be found to be unenforceable by the courts in about 30 seconds or so.

OK, so what does this have to do with aggregration?  The prevailing 
legal opinions seem to be that viral licenses cannot extend their
terms across boundaries.  The aggregration verbage is alluding to that
boundary.  If it is true that viral licenses cannot cross some sort of
boundary (and obviously it is true, otherwise the system call boundary
would not be recognized and all programs ever run on Linux would be GPLed),
then the GPL doesn't get to say what it means by that boundary, the law
gets to say that.  Just like the above "license" doesn't get to create
slaves, some issues are outside the license scope.

I've spoken with my lawyer in depth about this and the feeling is that
there are boundaries which licenses may not cross, and the definition
of such a boundary is one where you could remove the code on one side
of the boundary (aka interface), replace it with completely different 
code, and get substantially the same behaviour.  A device driver is a
good example.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
