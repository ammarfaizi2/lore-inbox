Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271414AbTGXPEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271687AbTGXPEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:04:14 -0400
Received: from mailrelay3.lanl.gov ([128.165.4.104]:9169 "EHLO
	mailrelay3.lanl.gov") by vger.kernel.org with ESMTP id S271414AbTGXPEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:04:08 -0400
Subject: Re: Posting format
From: Steven Cole <elenstev@mesatop.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, Tomas Szepe <szepe@pinerecords.com>
In-Reply-To: <bfn5v6$m20$1@gatekeeper.tmr.com>
References: <20030723201801.GB32585@rdlg.net>
	 <20030723212224.A527@infradead.org> <20030723220037.GC32585@rdlg.net>
	 <20030723225333.GC16244@louise.pinerecords.com>
	 <bfn5v6$m20$1@gatekeeper.tmr.com>
Content-Type: text/plain
Organization: 
Message-Id: <1059059667.1672.202.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 24 Jul 2003 09:14:28 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-23 at 17:32, bill davidsen wrote:
> A one or two line summary at the top of an article often saves the
> reader from reading the entire thing.
> 
> In article <20030723225333.GC16244@louise.pinerecords.com>,
> Tomas Szepe  <szepe@pinerecords.com> wrote:
[snipped]
> | 
> | Would you people please stop replying above the original messages?
> | 
> | One could say this evil (pioneered by certain silly mail clients btw)
> | has been spreading like plague around here lately.
> | 
> | Quoting the lkml FAQ ->
> | (REG) And please reply after the quoted text, not before it (as per RFC
> | 1855).  It's very confusing to see a reply before the quoted context.
> 
[snipped]
> 
> |                                                                   And
> | it's embarrassing: it makes you look like a newbie.  Change your mailer if
> | necessary, if the one you have makes it hard to do reply-after-quoting.
> | I know some people like to quote the entire message they are replying to,
> | so they put their reply right at the top so people won't give up after the
> | first page of quoted material.  Don't do it.  It's annoying.  Just learn to
> | stop quoting everything.  No-one wants to see it all anyway (list archives
> | allow people to see everything if they missed it).  You're not helping
> | yourself anyway, as you're more likely to be ignored if you
> | reply-before-quoting.
> 
> Seriously, you have a point, but his two liner did not require the
> context of the bulk of the post. There have been some far worse choices
> of top posting, and the main reason for not top posting is because it's
> hard to read *when context is needed*.
> 
> Your point is good, I think you could have picked a number of better
> examples to make it.

More exposition regarding top vs bottom posting: Replying at the bottom
results in an easily parseable tree. Consider the following conversation
where everyone replies at the bottom.

-------------------------------
To: hackerlist@webe.hackers.org
From: Delta <delta@cando.com>
Subj: foo.c does not compile, what to do?

Charlie wrote:
> Able wrote:
> > Baker wrote:
> > > Able wrote:
> > > > Baker wrote:
> > > > > Able wrote:
> > > > > > My driver foo.c does not compile. What can I do?
> > > > > > 
> > > > > > Able
> > > > > > 
> > > > > It hasn't been ported yet.  
> > > > > 
> > > > > Baker
> > > > > 
> > > > I really really need this.
> > > > 
> > > > Able
> > > > 
> > > Well then, either fix it yourself or find someone who can.
> > > 
> > > Baker
> > > 
> > But I can't fix it myself.  I don't know how.
> > 
> > Able
> > 
> I think Delta worked on this last year.  Delta, can you help?
> 
> Charlie
> 
Yeah I looked at that thing and ran away screaming.  Good luck.

Delta
-------------

Now, look at the same conversation where Able replies at the top.

-------------------------------
To: hackerlist@webe.hackers.org
From: Delta <delta@cando.com>
Subj: foo.c does not compile, what to do?

Charlie wrote:
> Able wrote:
> > But I can't fix it myself.  I don't know how.
> >
> > Able
> >
> > Baker wrote:
> > > Able wrote:
> > > > I really really need this.
> > > >
> > > > Able
> > > >
> > > > Baker wrote:
> > > > > Able wrote:
> > > > > > My driver foo.c does not compile. What can I do?
> > > > > > 
> > > > > > Able
> > > > > > 
> > > > > It hasn't been ported yet.
> > > > > 
> > > > > Baker
> > > > > 
> > > > 
> > > Well then, either fix it yourself or find someone who can.
> > > 
> > > Baker
> > > 
> > 
> I think Delta worked on this last year.  Delta, can you help?
> 
> Charlie
> 
Yeah I looked at that thing and ran away screaming.  Good luck.

Delta
-------------

The result is a tangled mess.  Untangling that mess wastes time.

Replying at the top wastes people's time trying to understand the
conversation.

For a theoretical discussion of why mixing top and bottom agglutination
is wrong, Steven Pinker's "The Language Instinct" has a chapter on how
differing languages build up trees.  Some add from the left, some from
the right, but arbitrarily mixing the two in the same sentence either
results in an ambiguity or what he calls "fruit salad".

Please reply at the bottom.

Steven



