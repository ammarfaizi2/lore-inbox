Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTLJXMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLJXMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:12:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:30953 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264239AbTLJXMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:12:39 -0500
Date: Wed, 10 Dec 2003 15:11:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: Hua Zhong <hzhong@cisco.com>, "'Arjan van de Ven'" <arjanv@redhat.com>,
       Valdis.Kletnieks@vt.edu, "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.10.10312101109380.3805-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.58.0312101452300.1273@home.osdl.org>
References: <Pine.LNX.4.10.10312101109380.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Andre Hedrick wrote:
>
> How can the additional words alter the mean of GPL itself?

They can't.

But they _can_ alter your ability to sue. In particular, if you publicly
state that you will not sue anybody over something, they can now use that
statement to make future plans. If at a later date you decide to sue them
anyway, they can point the judge at your earlier statement, and claim
estoppel against you.

So note how the license itself didn't change - but your ability to
_enforce_ the license has changed by virtue of you stating that you won't.

So while I publicaly say that I'm a lazy bastard, and the less I have to
do with lawyers, the better - I won't actually say that I will never sue
anybody. I'll say that it is "unlikely", or that people would have to
irritate me mightily.

For most developers that literally doesn't much matter what they say. Even
when _I_ say something, that doesn't really matter to what other
developers do, and while it could potentially limit me from enforcing _my_
copyrights, it doesn't stop others from enforcing theirs. So my random
email ramblings should really be construed as my opinions rather than any
legally relevant stuff.

However, the few extra lines in the main COPYING file end up being
somewhat binding to others, simply because they are _so_ public (they are,
after all, in the _main_ COPYING file) and they have been there pretty
much since the beginning, that they would basically end up being a very
strong argument in any legal case where some random kernel developer would
try to argue that it doesn't cover "their" code.

You don't have to agree to them, btw - you can remove them from the copy
of Linux you distribute, since the GPL in no way requires you to keep
them. They're not part of the copyright license per se, they are expressly
marked as being my personal viewpoint.  I suspect that if you do, you'll
find companies that would be slightly more nervous to work with you,
though.

But nobody has really ever argued against the clause, even originally. And
in this particular discussion, I don't believe anybody is actually arguing
against it now either. The legal meaning of it may be under discussion,
but I don't think anybody is really even _trying_ to argue that it should
be removed and that we should suddenly try to claim that any future user
programs have to be GPL'd.

Quite the reverse - I think everybody involved would argue that that would
just be crazy talk.

			Linus
