Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTIYXg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTIYXg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:36:26 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:55452 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S261732AbTIYXgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:36:24 -0400
Date: Fri, 26 Sep 2003 01:36:22 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>, Larry McVoy <lm@bitmover.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, <andrea@kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030925184906.GD18749@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0309260124000.2238-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003, Larry McVoy wrote:

> On Thu, Sep 25, 2003 at 11:15:33AM -0600, Eric W. Biederman wrote:
> > In addition there are some major gains to be had in standardizing on a
> > distributed version control system that everyone can use, and
> > unfortunately BK does not fill that position.  So I think it is good
> > that there is enough general discontent it the air that people
> > continue to look for alternatives. 
> 
> Let's just postulate that my claim that this is harder than it looks is
> true.  You don't have to agree with it, just pretend you do.  Given that,
> it's going to be a while before any alternative shows up.  People mumble
> about arch until they go use it for a while and realize it is about 3-5
> years behind BK.  Linus isn't about to step backwards that far.

Have you tried it lately? I'm not sure who's behind because I've never 
used bk, but only having a look at arch and using it for a couple of 
weeks would convince anybody of the opposite. Just wait that there is a 
linux arch repo with the bk detail and facts will speak.

That's why there's the need of having all the bk linux related repos
exported to CVS, not to limit linux development. If only one of these
repos is not exported, many people have difficulties in keeping off bk. I 
appreciate you comment that all will be exported RSN.

The same that you demand respect for bk, please respect the others too and
don't spread false comments. Moreover, you are on an advantadgeous
position as you can test arch, read its code and learn -it's GPLed-, while
the rest of people can't even benchmark arch with bk as it's forbidden by 
your license. Don't misunderstand me, I'm not flaming anyone, I'm just 
exposing facts.

> > The current situation with version control is painful.  
> 
> No kidding.  Do you have any suggestions, _realistic_ suggestions, that 
> we could do to help?  Beyond making plain text patches/tarballs available
> from every repo hosted on bkbits?

It would be great to keep an arch gateway with the same detail than bk 
changesets. It looks very easy to do.

Pau

