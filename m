Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTIZEnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 00:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTIZEnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 00:43:41 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:39816 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261921AbTIZEnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 00:43:40 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 25 Sep 2003 21:38:55 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Miles Bader <miles@gnu.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
In-Reply-To: <buooex8477g.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.56.0309252109370.967@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org>
 <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <buooex8477g.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2003, Miles Bader wrote:

> ebiederm@xmission.com (Eric W. Biederman) writes:
> > ARCH is barely distributed and architecturally it makes distributed
> > merging hard.
>
> Are you are kidding?  Arch is _insanely_ good at handling both
> distributed repositories and merging -- those are if anything its
> greatest strengths.  Everyday development of tla (the latest/greatest
> arch implementation) involves many people with their own repositories,
> merging back and forth.

I definitely agree. It's about a couple of months that I'm playing with it
and I have to say that it works great with distributed development. It
basically born with that as the very first design rule. It also look very
stable AFAICS. And, the old collection of shell scripts (that I didn't
like in the beginning) is shaping out toward C code. In three words, I
like it. I cannot compare it to bk because I never used it (not because
of the license, and not even for political/personal reasons, but because I
haven't had any time to do it in the past), and I am sure it still lacks
of some useful features when matched with bk, but the fundamentals are
definitely there.



- Davide

