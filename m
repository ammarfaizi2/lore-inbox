Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTIXChg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 22:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTIXChg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 22:37:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:49801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261249AbTIXChe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 22:37:34 -0400
Date: Tue, 23 Sep 2003 19:36:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: andrea@kernel.org
cc: Larry McVoy <lm@work.bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030924020409.GL16314@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Sep 2003 andrea@kernel.org wrote:
> 
> It's because I grow up that I can actually better understand the deals
> it's in my own (again speaking only for myself and not for anybody else)
> interest to avoid.

You've claimed this now twice. 

However, that only explains why you don't use BitKeeper. And everybody
accepts that. When I started to use BK, I made it _very_ clear that
service for non-BK users will be _at_least_ as good as it ever was before
I started using BK.

And I think everybody agrees that is true. ChangeLogs, CVS exports, daily 
snapshots. And that's just the advantages to _others_. 

But your lack of interest in BK does _not_ explain why you whine about it,
and try to goad Larry, and just generally are nasty about it. 

You remind me of how some of the BSD people complaining about me using the
GPL. They whined and whined about how the GPL is not as free as the BSD
license. 

In other words:

 - you don't have to agree with another persons choice of license, and 
   you don't have to to use the software using it. That is _your_ choice.

 - But you also don't have the moral right to whine about another persons
   choice of license (or choice of using software under that license). 
   That was _their_ choice.

See? You're not just being impolite; your complaints are actually morally 
offensive. The same way I found it morally offensive when people 
complained about my choice of GPL. They didn't have the right. And _you_ 
don't have the right.

It's the old 

	"I disapprove of what you say, but I will defend to the death your 
	 right to say it"

approach: even if you disapprove of Larry's license, you should defend his 
_right_ to that license. Instead of whining about it.

			Linus

