Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTJENiV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 09:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTJENiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 09:38:21 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:25231 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263108AbTJENiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 09:38:18 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Larry McVoy <lm@bitmover.com>, Rob Landley <rob@landley.net>,
       andersen@codepoet.org, "Henning P. Schmiedehausen" <hps@intermeta.de>,
       Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0310050423290.16540@dlang.diginsite.com>
References: <20030914064144.GA20689@codepoet.org>
	 <bk30f1$ftu$2@tangens.hometree.net> <20030915055721.GA6556@codepoet.org>
	 <200310041952.09186.rob@landley.net>
	 <20031005010521.GA21138@work.bitmover.com>
	 <1065349414.3157.8.camel@imladris.demon.co.uk>
	 <Pine.LNX.4.58.0310050423290.16540@dlang.diginsite.com>
Message-Id: <1065361053.3157.56.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Sun, 05 Oct 2003 14:37:33 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-05 at 04:32 -0700, David Lang wrote:
> why do people realize how stupid this argument when SCO makes it, but
> somehow when it's made on behalf of the GPL it somehow seems sane?

The distinction to be drawn here is between that which is allowed for by
copyright law, and that which is not.

Let us briefly assume, for the sake of argument, that the Linux kernel
was released under the Creosote Public Licence, a licence which requires
each licensee to perform a daily ritual of bathing in creosote, and to
release _all_ future work, even unrelated work, of his own under the
same licence.

If you don't like the terms of the CPL, you have the option of not using
the work in question.

If you use the work, however, you are bound by those terms. 

Let us assume, also merely for the sake of argument, that you can
produce a kernel module which is not so closely tied to the kernel that
it would be considered a derivative work in copyright law.

However, the CPL under which the kernel is released still requires that
you release this work under the CPL, even though under copyright law it
is not a derivative work.

You still have the same choice you had before. You may accept the
licence of the Linux kernel, continue to perform your daily bathing in
creosote and release your new work under the appropriate licence -- or
you may decline the licence of the Linux kernel and refrain from using
it at all.

If you take the latter option, then you may perform no testing on your
binary module, since that would require use of the Linux kernel. You may
use the Linux kernel nowhere within your organisation.

In this situation, it's not just about your module itself being an
infringing copy of a copyright work, but your copy of the Linux kernel
_itself_ being an infringing copy.

Obviously the GNU General Public License makes no mention of creosote,
and its use with the Linux kernel does not require that you license
_all_ future work under the GPL. 

I have made a statement about my opinion of what the licence of the
Linux kernel _does_ in fact require. It is my belief that the author of
the GNU General Public License is in agreement with me. 

In particular, in this case, I think the presence of the userspace
exception makes it _very_ clear that the meaning of 'derived work' would
otherwise have included both userspace and loadable modules. 

Obviously this is neither true or false until the matter is settled in a
court; it's all conjecture. But I think a court will agree with me.

>  how many people would buy this argument if it was being made about some 
> function in a piece of hardware? (i.e., if you use this function on this 
> 802.11 card then your software is obviously a derivitive[sic] of our driver 
> so we get all the rights to it)

I'd buy the _argument_, even if the licence were to require the ritual
sacrifice of my first-born child. I wouldn't buy the card in question
and use that function though. I have that choice.

If I _did_ choose to use the function in question, I would not then
whinge that it's not fair when they come for my first-born. That was the
agreement I entered into, after all.

-- 
dwmw2


