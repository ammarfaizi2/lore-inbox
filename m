Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUJXQpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUJXQpi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUJXQph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:45:37 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:62772 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261551AbUJXQoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 12:44:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BDHmyIAwv8M3GPs6/CW4jFD9nVbodiNmNOMUhg6LIXXk9HTVsjDjSIzcoN043WACBRJ6gctFqMxwvUdMg8kvTm1w8qXzIG33R4ZkytXAEApsSomuVYpBrWBn6d8M+OCGAkQhbXFJRIgmeR3P4K2E2GiJHn7OxQqVE6Z2YR5m4mI=
Message-ID: <4d8e3fd304102409443c01c5da@mail.gmail.com>
Date: Sun, 24 Oct 2004 18:44:38 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Larry McVoy <lm@work.bitmover.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <20041024144448.GA575@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41752E53.8060103@pobox.com>
	 <20041019153126.GG18939@work.bitmover.com>
	 <41753B99.5090003@pobox.com>
	 <4d8e3fd304101914332979f86a@mail.gmail.com>
	 <20041019213803.GA6994@havoc.gtf.org>
	 <4d8e3fd3041019145469f03527@mail.gmail.com>
	 <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
	 <20041023161253.GA17537@work.bitmover.com>
	 <4d8e3fd304102403241e5a69a5@mail.gmail.com>
	 <20041024144448.GA575@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004 07:44:48 -0700, Larry McVoy <lm@bitmover.com> wrote:
> On Sun, Oct 24, 2004 at 12:24:42PM +0200, Paolo Ciarrocchi wrote:
[...]
> >
> > Well, I'm not interested in having the list of all the bk trees used
> > during the develpoment of a release.
> > I was looking to the trees used by mantainers.
> 
> And how do you define a maintainer?  That's a moving target.  Part of the
> beauty of the Linux development model is that mini forks are not only
> allowed, they are encouraged.  So people can go off on their own and do
> something interesting.  Who knows?  One of those people could be the next
> Alan.

I totally agree on the "beauty of Linux development" part of your statement,
I don't 100% agree on your definition of maintainer.
There a few well defined maintainer in the community and those names
are defined and written in the kernel documentation.
So, I think that is moving target but we have a few stable and well
know references.

> > That number should me really different from "1,000".
> 
> Sure.  But even so it's a moving target and labeling a set of people as
> maintainers implies that other people aren't.  I suspect Linus isn't
> that interested in the labels, he'll take good code from anyone.

Good point, 
even though I'm almost sure that both Linus and Andrew prefer getting
patches after they are reviewed by those "maintainers".

Anyway, 
I'm not a kernel hacker at all so my comments will sound just silly to
a lot of people involved in the development but as a user I'm
sometimes "alarmed" by the lack of formality in the development
process (see the naming wars),

Maybe we cannot avoid it, maybe that's the reason because linux is
"the best free OS" but maybe we can add a few more rules/indications
to the process.

Larry,
thank you for your answer, I always appreciate having such a kind of
open discussions with people that are really involved in the
development.

Ciao,
-- 
Paolo
