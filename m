Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTJEKYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 06:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTJEKYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 06:24:16 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:62092 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263056AbTJEKYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 06:24:15 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: Larry McVoy <lm@bitmover.com>
Cc: Rob Landley <rob@landley.net>, andersen@codepoet.org,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20031005010521.GA21138@work.bitmover.com>
References: <20030914064144.GA20689@codepoet.org>
	 <bk30f1$ftu$2@tangens.hometree.net> <20030915055721.GA6556@codepoet.org>
	 <200310041952.09186.rob@landley.net>
	 <20031005010521.GA21138@work.bitmover.com>
Message-Id: <1065349414.3157.8.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Sun, 05 Oct 2003 11:23:34 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-10-04 at 18:05 -0700, Larry McVoy wrote:
> Yeah, but Linus stating his position about a license doesn't mean diddly.
> The kernel is licensed under a license, that license is a contract that
> people enter into.  To the extent that it is enforceable, that license
> determines what happens, Linus can't retroactively decide to interpret
> the license a different way.  The license can't enforce things which
> the law doesn't allow.  In particular, the law understands a concept of
> a boundary. 

I agree. Linus' comments on the matter, except of course his original
exception for userspace which has been there since 1993, are an
irrelevant _interpretation_.

All that is relevant is the meaning of the original licence.

>  And Linus' comments notwithstanding, modules are a pretty
> clear boundary.  Even the GPL acks this, it knows that anything which
> is clearly separable is not covered.

This statement is in conflict with the presence of the exception for
userspace which precedes the text of the GPL in the Linux COPYING file.

The presence of the exception makes it clear that, without such
exception, userspace would have been considered to be a derived work in
the terminology of the original licence. Otherwise, the exception would
of course have been redundant.

If userspace would be considered a derived work without explicit
exception, then so are kernel modules. They have no such explicit
exception, and are hence not permitted.

I'll grant you that Linus' witterings in public on the matter would
probably prevent him _personally_ from bringing suit against a
distributor of binary-only modules, on the principle of equitable
estoppel.

That doesn't stop me or anyone else from doing so though.

-- 
dwmw2


