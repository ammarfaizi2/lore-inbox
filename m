Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVBCWgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVBCWgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbVBCWb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:31:26 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:17059 "EHLO
	postbox.bitmover.com") by vger.kernel.org with ESMTP
	id S263135AbVBCW3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:29:02 -0500
Date: Thu, 3 Feb 2005 14:28:54 -0800
To: Stelian Pop <stelian@popies.net>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050203222854.GC20914@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Stelian Pop <stelian@popies.net>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203220059.GD5028@deep-space-9.dsnet>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really don't want to start a new BK flamewar. You asked what could
> you do and I said what would be nice to have. End of story.
> 
> >     - The idea that the granularity in CVS is unreasonable is pure
> 
> I didn't say it was unreasonable, I said it could be better.

Sure, everything can always be better.  Reasonable is reasonable.  If
you want more than reasonable then use BK.

> > 		CVS		BitKeeper [*]
> > 	Deltas	235,956		280,212
> 
> Indeed, for now the differences are rather small. But with more and
> more BK trees and more merges between them the proportion will raise.

Actually that's not been the case to date, it's held pretty constant
and in fact the ratio has gotten better.  The last time we visited 
these numbers it wasn't as good as it is today in CVS>

> If Andrew were to start using BK today we could immediately lose
> (on the CVS side) a big part of the history.

"A big part"?  What big part?  You are fixated on something that doesn't
have any value.  You're complaining about losing information that CVS
wouldn't have recorded if you were using CVS.  The CVS export tree has
MORE information than you would have if all the development had been 
done under CVS.  Explain to me why this information is suddenly so 
valuable to you?  Explain to me why all the people using all the CVS
maintained projects in the world aren't whining about all the lost 
information.

> It is a bit difficult to get it right wrt renames, deletes etc, and
> it can take quite a while to execute, but 3 man month work is a bit
> extreme.

I stand by the 3 month number.

> I thought the competition was between the tools not the data inside...
> Why is that every time someone wants the full history of the kernel
> you think it wants to compete with you ? That history is not even a
> secret, everybody can get it from BK/web or by running the free
> edition of BK (if allowed).

Right but people agree to not use BK to compete with us.  It's a form
of payment for the product, we give it to you for no money and you agree
not to copy the product and take away our business.

I realize you hate this, it curtails your freedom, there are a thousand
reasons not to like it, I wouldn't like it if I were in your shoes.
I get it, it's a miserable arrangement.  However, we took a huge risk
handing you and everyone else our product for free.  It works better, you
can see that, and you are just the sort to try and reverse engineer it.
As a business strategy it was foolish.  But it wasn't a business decision,
it was a choice that I made because I wanted to help Linus.

And it worked.  That ought to have some value in your eyes.  Maybe
enough to respect our terms.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
