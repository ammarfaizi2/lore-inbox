Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTJELhX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 07:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbTJELhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 07:37:23 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:41692 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261342AbTJELhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 07:37:22 -0400
From: David Lang <david.lang@digitalinsight.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>, Rob Landley <rob@landley.net>,
       andersen@codepoet.org, "Henning P. Schmiedehausen" <hps@intermeta.de>,
       Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Date: Sun, 5 Oct 2003 04:32:59 -0700 (PDT)
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <1065349414.3157.8.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.58.0310050423290.16540@dlang.diginsite.com>
References: <20030914064144.GA20689@codepoet.org>  <bk30f1$ftu$2@tangens.hometree.net>
 <20030915055721.GA6556@codepoet.org>  <200310041952.09186.rob@landley.net>
  <20031005010521.GA21138@work.bitmover.com> <1065349414.3157.8.camel@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Oct 2003, David Woodhouse wrote:

> The presence of the exception makes it clear that, without such
> exception, userspace would have been considered to be a derived work in
> the terminology of the original licence. Otherwise, the exception would
> of course have been redundant.
>
> If userspace would be considered a derived work without explicit
> exception, then so are kernel modules. They have no such explicit
> exception, and are hence not permitted.

no, all the presence of the userspace exception means is that someone
attempted to make the claim that you would only be allowed to run GPL
software on a GPL kernel and Linus wanted to make it absolutly clear that
that wasn't the case.

trying to claim otherwise, even without a specific 'userspace exception'
is along the same lines as what SCO is doing, (anything that ever ran on
the same box as Sys V is part of SysV)

why do people realize how stupid this argument when SCO makes it, but
somehow when it's made on behalf of the GPL it somehow seems sane?

as got the GPL_only stuff, I am seriously worried about people defining
something and then declaring that anything that uses it in any way must be
a derived work, that there is no other legitimate way to use it. how many
people would buy this argument if it was being made about some function in
a piece of hardware? (i.e., if you use this function on this 802.11 card
then your software is obviously a derivitive of our driver so we get all
the rights to it)

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
