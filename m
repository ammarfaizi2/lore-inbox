Return-Path: <linux-kernel-owner+w=401wt.eu-S1754588AbWLRVD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbWLRVD5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbWLRVD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:03:57 -0500
Received: from hu-out-0506.google.com ([72.14.214.239]:50886 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbWLRVD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:03:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=C1yjb2z9/pYXv7zWE9pN6RFMaIS/Jn9nbux0/D7mmqvOnCAwezSUMv2QmIS8ZKnirVmfl2E1hZ7DCkUkhR0fbxBSEHbb/WvnRcawmb9GjUem+vfCpDYOuCTlXLmdlaCou6sC9vJoyTis+tUSWOTK1Quv9JI7n4KogGgJnHjqgcA=
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
	for 2.6.19]
From: karderio <karderio@gmail.com>
Reply-To: karderio@gmail.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org>
References: <1166226982.12721.78.camel@localhost>
	 <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org>
	 <1166236356.12721.142.camel@localhost>
	 <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org>
Content-Type: text/plain
Organization: karderio
Date: Mon, 18 Dec 2006 22:04:07 +0100
Message-Id: <1166475847.20449.208.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi :o)

On Fri, 2006-12-15 at 18:55 -0800, Linus Torvalds wrote:
> But the point is, "derived work" is not what _you_ or _I_ define. It's 
> what copyright law defines.

Of course not. I never suggested trying to define a derived work.

> And trying to push that definition too far is a total disaster. If you 
> push the definition of derived work to "anything that touches our work", 
> you're going to end up in a very dark and unhappy place. One where the 
> RIAA is your best buddy.

I don't see how what is proposed for blocking non GPL modules at all
touches the definition of derived work. Even if according to law and the
GPL, binary modules are legal, the proposed changes could still be
made. 

I have realised that the proposed changes do not *impose* any more
restriction on the use of the kernel than currently exists. Currently
the Kernel is licenced to impose the same licence on derived works,
enforce distribution of source code etc. and this by law. The proposed
changes do not impose anything, they just make things technically a
little more complicated for some, and they can be trivially circumvented
if one desires. Maybe not a good idea, but still no excuse for the sort
of atrocious bigotry some people are exhibiting here.

I do not mean to say this is a good thing, some of the arguments
advanced here make me much less enthusiastic as at the beginning. As I
said in my first post, and seemed to be promptly ignored, this can only
by any use at all if it persuades vendors to provide the essential
information about their products without hurting users too much, or
further alienating vendors. All this is of course highly debatable, and
needs discussing properly, if people are able to communicate in a civil
manner that is.

Before any fanatic ranting saying that people inducing slight
complications are freedom hating Nazis who should be burned at the
stake, please contrast this trivial complication with the extremely
difficult work that must be done by someone wanting to write a driver
when a vendor doesn't provide adequate documentation.

It might be noted that in some countries it is quite illegal not to
provide documentation for a product, just as it is illegal to limit a
product to only work with a specific vendors merchandise when said
product is in essence generic. This is the case in France, where these
laws are simply ignored by corporations. A large French NFP sued HP last
week about them not allowing their PCs to be sold without Windows, so we
may finally start to get these laws applied. I have written the NFP to
suggest that if the case does not extend to missing hardware
documentation, maybe another case would be in order. In the past the
people at this NFP have been very civil and cooperative with me.

> And that is why it would be WRONG to think that we have the absolute right 
> to say "that is illegal". It's simply not our place to make that 
> judgement. When you start thinking that you have absolute control over the 
> content or programs you produce, and that the rest of the worlds opinions 
> doesn't matter, you're just _wrong_.

I have seen nobody with the ponce to judge people or try to have control
over them when arguing for these mods. I think all that has been said
has been people trying to interpret the law, it's quite possible they
got it wrong. Not that I can blame them, law is a not simple, and I can
see people on both "sides" of the argument not getting things quite
right here.

I would note however that I personally find it distasteful to call
people "wrong" rather than respectfully disagreeing with them.

> So don't go talking about how we should twist peoples arms and force them 
> to be open source of free software. Instead, BE HAPPY that people can take 
> advantage of "loopholes" in copyright protections and can legally do 
> things that you as the copyright owner might not like. Because those 
> "loopholes" are in the end what protects YOU.

I admit I should not have used the phrase "twist arm", I meant it in an
entirely jocular sense, it is a phrase I never employ usually. Of course
it is a mistake I regret. The word "persuade" would have been a much
better choice.

As I hope I clearly explained above, it wasn't suggested to "force"
anybody to do anything.

Although I don't appreciate insult or aggressively, I choose to ignore
it in order to try and advance a reasonable discussion. I will not stand
here and let you tell me what to and not to do however. It also makes
you seem a bit hypocritical in a discussion where you are claiming to be
arguing for "freedom".

Love, Karderio.


