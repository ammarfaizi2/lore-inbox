Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTIXDnC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbTIXDnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:43:02 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:11792 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261411AbTIXDm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:42:59 -0400
Date: Tue, 23 Sep 2003 23:42:47 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@work.bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030924032837.GP16314@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0309232340230.15940-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003, Andrea Arcangeli wrote:

> the latest not, but that was the latest, and I still recommend Marcelo
> to stop using bitkeeper and to do the checkins directly in cvs. That
> would be a start

That would break so many 3rd party trees. It would mean
Marcelo would no longer be able to just pull in eg. the
PPC tree, it would mean merging pain for branched trees,
etc...

> and it would motivate me more too into adding more effort there.

Effort where ?

If you're talking about adding more effort into merging
things into 2.4, then DUH. You would NEED more effort to
get stuff merged, if marcelo used something as bad as CVS.

If you're talking about improving CVS, don't bother. The
model is broken.

> I need a bit of feedback from a kernel maintainer that there will be a
> slight chance to use something non bitkeeper in the future before I
> invest a bit of (probably my spare) time into this.

There's more than a slight chance.  Just come up with
something that's as good as, or better than, bitkeeeper
and people will switch in a heartbeat.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

