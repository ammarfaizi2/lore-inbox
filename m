Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTIXCs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 22:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTIXCs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 22:48:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24476
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261297AbTIXCs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 22:48:26 -0400
Date: Wed, 24 Sep 2003 04:48:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: andrea@kernel.org, Larry McVoy <lm@work.bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924024831.GO16314@velociraptor.random>
References: <20030924020409.GL16314@velociraptor.random> <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 07:36:39PM -0700, Linus Torvalds wrote:
> 
> On Wed, 24 Sep 2003 andrea@kernel.org wrote:
> > 
> > It's because I grow up that I can actually better understand the deals
> > it's in my own (again speaking only for myself and not for anybody else)
> > interest to avoid.
> 
> You've claimed this now twice. 
> 
> However, that only explains why you don't use BitKeeper. And everybody
> accepts that. When I started to use BK, I made it _very_ clear that
> service for non-BK users will be _at_least_ as good as it ever was before
> I started using BK.
> 
> And I think everybody agrees that is true. ChangeLogs, CVS exports, daily 
> snapshots. And that's just the advantages to _others_. 
> 
> But your lack of interest in BK does _not_ explain why you whine about it,
> and try to goad Larry, and just generally are nasty about it. 

I wasn't whining about BK at all, nor about the licence, I just
advertized the open links in my signature, the word "refuse" may be not
a nice one, I didn't feel to be rude when I wrote it, now I changed it
and I hope it's a more friendly wording, though the meaning it's the
same.

> approach: even if you disapprove of Larry's license, you should defend his 
> _right_ to that license. Instead of whining about it.

I defend his right to the licence, it makes perfect business sense, if
he wanted to be safer he had to take a couple of patents too I guess
(but I'm not a lawyer and I certainly prefer the licence to the
patents). I don't think I ever complained to the licence.  I only said
I'm not applying to the licence and _you_ have to respect my _right_ not
to use the software and to advertize the _open_ links, without seeing it
as an offensive thing.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
