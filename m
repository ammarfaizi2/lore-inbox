Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031280AbWI1ATN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031280AbWI1ATN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031281AbWI1ATN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:19:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031280AbWI1ATM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:19:12 -0400
Date: Wed, 27 Sep 2006 17:18:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chase Venters <chase.venters@clientec.com>
cc: Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.64.0609271808041.7316@turbotaz.ourhouse>
Message-ID: <Pine.LNX.4.64.0609271641370.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <1159319508.16507.15.camel@sipan.sipan.org> <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
 <1159342569.2653.30.camel@sipan.sipan.org> <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
 <1159359540.11049.347.camel@localhost.localdomain> <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
 <Pine.LNX.4.64.0609271300130.7316@turbotaz.ourhouse> <20060927225815.GB7469@thunk.org>
 <Pine.LNX.4.64.0609271808041.7316@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Sep 2006, Chase Venters wrote:
> On Wed, 27 Sep 2006, Theodore Tso wrote:
> > 
> > This has been made clear to Eben and the FSF, for a long time.  The
> > FSF has simply chosen not to listen to Linus and other members of the
> > kernel community.  In fact, I've never seen any interest in a
> > dialogue, just a pseudo-dialogue where "input is solicited", and then
> > as near as far as I can tell, at least on the anti-Tivo issue, has
> > been simply ignored.  But in any case, it should not have come as a
> > surprise and should not have startled anyone.
> 
> Perhaps I came off too strong, but I meant what I said, and I'm not only
> talking about things being made clear with Eben and the FSF. Frankly, I don't
> know what did or did not happen behind closed doors and it would be wrong of
> me to make assumptions about that.

I think a lot of people may be confused because what they see is

 (a) Something that has been brewing for a _loong_ time. There has been 
     the FSF position, and there has been the open source position, and 
     the two have been very clearly separated.

     At the same time, both camps have been trying to be somewhat polite, 
     as long as the fact that the split does clearly exist doesn't 
     actually _matter_.

     So, for example, the GPLv2 has been acceptable to all parties (which 
     is what I argue is its great strength), and practically you've not 
     actually had to care. In fact, most programmers _still_ probably 
     don't care. A lot of people use a license not because they "chose" 
     it, but because they work on a project where somebody else chose the 
     license for them originally.

     This, btw, is probably why some things matter to me more than many 
     other kernel developers. I'm the only one who really had an actual 
     choice of licenses. Relatively, very few other people ever had to 
     even make that choice, and as such, I suspect that a number of people 
     just feel that it wasn't their choice in the first place and that 
     they don't care that deeply.

     Ted is actually likely one of the very few people who were actually 
     involved when the choice of GPLv2 happened, and is in the almost 
     unique situation of probably having an email from me asking if he was 
     ok with switching from my original license to the GPLv2. Ted?

     So we have something that has been going on for more than a decade 
     (the actual name of "Open Source" happened in 1998, but it wasn't 
     like the _issues_ with the FSF hadn't been brewing before that too), 
     but that has mostly been under the surface, because there has been no 
     _practical_ reason to react to it.

 (b) This tension and the standpoints of the two sides has definitely 
     _not_ been unknown to the people involved. Trust me, the FSF knew 
     very well that the kernel standpoint on the GPLv2 was that Tivo was 
     legally in the right, and that it was all ok in that sense.

     Now, a number of people didn't necessarily _like_ what Tivo does or 
     how they did it, but the whole rabid "this must be stopped" thing was 
     from the FSF side. 

> What I was really addressing here is that the whole F/OSS community 
> exploded over the news that Linux was not adopting the GPLv3.

Not really. It wasn't even news. The kernel has had the "v2 only" thing 
explicitly for more than half a decade, and I have personally tried to 
make it very clear that even before that, it never had anything else (ie 
it very much _had_ a specific license version, just by including the damn 
thing, and the kernel has _never_ had the "v2 or any later" language).

So legally, Linux has generally been v2-only since 1992, and just to head 
off any confusion, it's even been very explicit for the last five years.

So what's the "news" really?

I'll tell you what the news is: the FSF was going along, _as_if_ they had 
the support of not just their own supporters, but the OSS community too, 
even though they knew _full_well_ what the differences were.

In fact, a lot of people have felt that they've been riding of the 
coat-tails of Linux - without ever realizing that one of the things that 
made Linux and Open Source so successful was exactly the fact that we did 
_not_ buy into the rhetoric and the extremism.

Claiming that the FSF didn't know, and that this took them "by surprise" 
is just ludicrous. Richard Stallman has very vocally complained about the 
Open Source people having "forgotten" what was important, and has talked 
about me as if I'm some half-wit who doesn't understand the "real" issue.

In fact, they still do that. Trying to explain the "mis-understanding". 

It was _never_ a mis-understanding. And I think the only surprise here was 
not how the kernel community felt, but the fact that Richard and Eben had 
probably counted on us just not standing up for it.

THAT is the surprise. The fact that we had the _gall_ to tell them that 
we didn't agree with them.

The fact that we didn't agree was not a surprise at all.

> I think it's fair to say that the reason why Linux is not adopting GPLv3 
> (aside from the very practical matter of gaining the consensus of 
> copyright holders) is that Linus and other top copyright holders don't 
> think what Tivo is doing is wrong.

Well, I personally believe that Tivo did everything right, but in the 
interest of full disclosure, sure, some people even _do_ belive that what 
Tivo is doing is wrong, but pretty much everybody agrees that trying to 
stop them is _worse_ than the thing it tries to fix.

Because the even _deeper_ rift between the FSF and the whole "Open Source" 
community is not over "Tivo" or any particular detail like that, but 
between "practical and useful" and "ideology".

And no, it's not a black-and-white issue. There are all kinds of shades of 
gray, and "practical" and "ideology" aren't even mutually incompatible! 
It's just that sometimes they say different things.

And yes, I personally exploded, but hey, it's been brewing for over a 
decade. Let me over-react sometimes. I'm still always right ;)

			Linus
