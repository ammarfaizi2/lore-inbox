Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSJaRT3>; Thu, 31 Oct 2002 12:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265286AbSJaRT2>; Thu, 31 Oct 2002 12:19:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265285AbSJaRT0>; Thu, 31 Oct 2002 12:19:26 -0500
Date: Thu, 31 Oct 2002 09:25:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Matt D. Robinson" <yakker@aparity.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210310900130.20412-100000@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Ok, this is a really serious email. If you don't get it, don't bother 
  emailing me. Instead, think about it for an hour, and if you still don't 
  get it, ask somebody you know to explain it to you. ]

On Thu, 31 Oct 2002, Matt D. Robinson wrote:
> 
> Sure, but why should they have to?  What technical reason is there
> for not including it, Linus?

There are many:

 - bloat kills:

	My job is saying "NO!"

	In other words: the question is never EVER "Why shouldn't it be
	accepted?", but it is always "Why do we really not want to live 
	without this?"

 - included features kill off (potentially better) projects.

	There's a big "inertia" to features. It's often better to keep 
	features _off_ the standard kernel if they may end up being
	further developed in totally new directions.

	In particular when it comes to this project, I'm told about
	"netdump", which doesn't try to dump to a disk, but over the net.
	And quite frankly, my immediate reaction is to say "Hell, I
	_never_ want the dump touching my disk, but over the network
	sounds like a great idea".

To me this says "LKCD is stupid". Which means that I'm not going to apply 
it, and I'm going to need some real reason to do so - ie being proven 
wrong in the field.

(And don't get me wrong - I don't mind getting proven wrong. I change my 
opinions the way some people change underwear. And I think that's ok).

> I completely don't understand your reasoning here.

Tough. That's YOUR problem.

		Linus

