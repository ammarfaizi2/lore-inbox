Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUDFXdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbUDFXdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:33:00 -0400
Received: from web40506.mail.yahoo.com ([66.218.78.123]:62272 "HELO
	web40506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264058AbUDFXc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:32:58 -0400
Message-ID: <20040406233257.84968.qmail@web40506.mail.yahoo.com>
Date: Tue, 6 Apr 2004 16:32:57 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: viro@parcelfarce.linux.theplanet.co.uk,
       Timothy Miller <miller@techsource.com>
Cc: Sergiy Lozovsky <serge_lozovsky@yahoo.com>, root@chaos.analogic.com,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040406225711.GM31500@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Apr 06, 2004 at 06:44:48PM -0400, Timothy
> Miller wrote:
> > >5. Well known. So there would be people around
> who
> > >already know this language and expectations are
> clear.
> > >And there are books around about this language.
> > 
> > LISP completely violates this requirement.  While
> I appreciate the power 
> > of LISP for abstraction, list processing, and how
> it lends itself 
> > towards many AI-related tasks, it's not a
> commonly-used language.
> 
> Whether it's commonly-used or not, there's another
> killer problem with LISP -
> it's fragmented worse than even Pascal. 

Can I have more details? All LISPs I know manage
memory by themselves as well as the one I use. They
allocate memory pool, create a list of free cells in
it and that's it. What is the problem? Yes, cells in
the free list are not contiguous, it's a list.

> And "which
> subset and extensions
> do we have in $IMPLEMENTATION" is worth "which
> language are we dealing with".
> Worse, actually.  If you want a functional language
> - at least pick a
> well-defined one.

I use a subset of big lisps (Common Lisp should I
say?). All function are described in manual which goes
with my system. And I'm not going to run some
previously created LISP programs. So exact
compatibility is not an issue. At the same time if a
person wants to understand what is CAR or CDR - there
are different sources of information available except
manual I provide (which is reference, not a LISP
textbook).

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
