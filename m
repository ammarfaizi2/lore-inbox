Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947078AbWKKDpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947078AbWKKDpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 22:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947079AbWKKDpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 22:45:46 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45442 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1947078AbWKKDpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 22:45:45 -0500
Message-Id: <200611101548.kAAFm4EN004162@laptop13.inf.utfsm.cl>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Adrian Bunk" <bunk@stusta.de>
Subject: Re: A proposal; making 2.6.20 a bugfix only version. 
In-Reply-To: Message from "Jesper Juhl" <jesper.juhl@gmail.com> 
   of "Wed, 08 Nov 2006 23:40:27 BST." <9a8748490611081440u6ba6c541h1038ac1e530e2839@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Fri, 10 Nov 2006 12:48:04 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:29:37 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 11 Nov 2006 00:43:58 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 08/11/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > There's no shortage of issues that need fixing, but since we keep
> > > merging new stuff, a lot of bugfixing energy gets spend on the new
> > > cool stuff instead of fixing up any other issues we have.
> >
> > but if you do this you just end up with a bigger backlog so that the
> > next one will even be more unstable due to a extreme high change rate.

> Only if people continue to work on new stuff during the "bug fixing only"
> cycle.  If we manage to get everyone focused on bug fixing only for the
> entire cycle the backlog won't be growing (much).

Sorry, won't work. People working on shiny new toys will just put off
sending in their patches for a cycle, and the usual bugfixers will likewise
just go on doing their stuff.

> > > Coverity has, as of this writing, identified 728 issues in the current
> > > kernel. Sure, some of those have already been identified as false or
> > > ignorable issues, but many are flagged as actual bugs and still more
> > > are as yet uninspected.

> > most are mostly false. And the rest is getting looked at. What's the
> > problem?

> Yes, MANY are false, and I know the rest are getting worked at, I work on
> some myself when time permits.  I mentioned it simply as an indicator
> (one amongst many) that we have a lot of known unfixed issues.

OK, lead by example: Do put off new work and work just on fixing things for
a while. Collect bug reports and make them useful for would-be-fixers. Etc.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
