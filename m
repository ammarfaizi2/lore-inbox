Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265239AbSJaRDj>; Thu, 31 Oct 2002 12:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSJaRDi>; Thu, 31 Oct 2002 12:03:38 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:26695 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265239AbSJaRDe>; Thu, 31 Oct 2002 12:03:34 -0500
Date: Thu, 31 Oct 2002 09:18:00 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210310900130.20412-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:
|>On Wed, 30 Oct 2002, Matt D. Robinson wrote:
|>That's fine. And since they are paid to support it, they can apply the 
|>patches.  

Sure, but why should they have to?  What technical reason is there
for not including it, Linus?

I completely don't understand your reasoning here.  I use it for my
home, not for work, and that's important for me.  And not everyone
can spend their evenings rolling up the next set of patches for
a distribution.  Yes, vendors want it, they need it, but there are
plenty of people like me that want this in too!

We want to see this in the kernel, frankly, because it's a pain
in the butt keeping up with your kernel revisions and everything
else that goes in that changes.  And I'm sure SuSE, UnitedLinux and
(hopefully) Red Hat don't want to spend their time having to roll
this stuff in each and every time you roll a new kernel.

I mean, PLEASE, Linus, what do we have to do?  There are so many
interests in this stuff, and I really, truly don't get what's wrong
with putting this in the kernel?

Have you looked at it?  Have you looked at how it is now structure
to be non-invasive?  How it will allow other kernel developers to
generate their own dumping methods?  I mean, we sent you E-mails
weeks ago, and you didn't respond to any of them with even a word
of acknowledgement of receipt.

|>What I'm saying by "vendor driven" is that it has no relevance for the 
|>standard kernel, and since it has no relevance to that, then I have no 
|>incentives to merge it. The crash dump is only useful with people who 
|>actively look at the dumps, and I don't know _anybody_ outside of the 
|>specialized vendors you mention who actually do that.

I do.  Others like myself do.  And not just for development
purposes.  I don't like to see my system crash after installing one
of your new kernels and not be able to figure out what's wrong.
The nice thing is that LKCD there, it works, and I can just look
at the crash report instead of wishing that my console buffer
didn't just scroll off.  Oh, I know, I'll just wait for it to
happen again ... yeah, like that's real intelligent.

|>I will merge it when there are real users who want it - usually as a
|>result of having gotten used to it through a vendor who supports it. (And
|>by "support" I do not mean "maintain the patches", but "actively uses it"
|>to work out the users problems or whatever).
|>
|>Horse before the cart and all that thing.
|>
|>People have to realize that my kernel is not for random new features. The
|>stuff I consider important are things that people use on their own, or
|>stuff that is the base for other work. Quite often I want vendors to merge
|>patches _they_ care about long long before I will merge them (examples of
|>this are quite common, things like reiserfs and ext3 etc).

Other vendors have merged LKCD a long time ago and use it, and
expect it to be there.  And users like myself find it valuable on
their desktops, their servers, etc.  I mean, there's someone using
this at Purdue that's responded to you, just another kernel user
that likes to have this stuff there automatically.

|>THAT is what I mean by vendor-driven. If vendors decide they really want
|>the patches, and I actually start seeing noises on linux-kernel or getting
|>requests for it being merged from _users_ rather than developers, then
|>that means that the vendor is on to something.

TurboLinux, MonteVista, Veritas, SuSE, and UnitedLinux have LKCD.
With the most recent changes, I think Red Hat can put LKCD in now
such that it isn't invasive to their distribution.

I think SuSE has already expressed a desire to have this in.  If
you want to hear from others, I'll asked them to respond to you.

|>		Linus

--Matt

