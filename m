Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUHUVwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUHUVwa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267922AbUHUVwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:52:30 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:16300 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S267928AbUHUVuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:50:46 -0400
From: Bryan Cantrill <bmc@zion.eng.sun.com>
Message-Id: <200408212149.i7LLnIeu144328@zion.eng.sun.com>
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <87d61k4rmr.fsf@killer.ninja.frodoid.org> from Julien Oster at "Aug 21, 2004 02:12:12 pm"
To: lkml-7994@mc.frodoid.org (Julien Oster)
Date: Sat, 21 Aug 2004 14:49:18 -0700 (PDT)
Cc: kloczek@rudy.mif.pg.gda.pl, usenet-20040502@usenet.frodoid.org,
       miles.lane@comcast.net, linux-kernel@vger.kernel.org,
       bmc@kiowa.eng.sun.com
X-Mailer: ELM [version 2.4ME+ PL31H (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > PS. Very interesting commens about this thread is on Bryan Cantrill
> > (DTrace developer) blog:
> > http://blogs.sun.com/roller/page/bmc/20040820#dtrace_on_lkml
> > Bryan blog is also yet another Dtrace knowledge source ..
> 
> Oh, yeah, great. A whole blog entry dedicated to me. Now I am a moron,
> absolutely clueless and I am "looking to confirm preconceived notions
> rather than understand new technology".
> 
> Sorry, but that goes a little too far. No, I didn't try out dtrace
> and, right after reading the article (and that's the important thing!)
> I didn't seek for further information about it, I'm not a Solaris
> System Administrator right now (I was, some years ago). And all I was
> saying is that this *article* was just ridiculous.

As a reminder, you _didn't_ read the entire article, by your own admission:

  That article is way too hypey...  I couldn't even read it completely,
  it was just too much.

And that was actually my point:  you spent more time denigrating the article
for lack of supporting detail than it would have taken you to _finish_ the
article and discover those supporting details.  

> But in that article, I was just missing the objectiveness. A quick
> note about the fact that Sun's been introducing dtrace for Solaris 10
> and what it is, what it does, would have been much better instead of
> talking about a "Cantrill explosion", how "DTrace has completely
> changed the way I do business" (actual quotes).

You don't like customer quotes?  It seems to me that quotes like that
one (or like the other customer quotes that appear in the article)
give weight to the claims.  Don't you like to hear from people who have
actually _used_ a technology?  I know that I do -- those who have used
a technology are likely to have a much more balanced view on its
strengths and weaknesses than those who have just read about it.  (Indeed,
this is true of pretty much anything -- experience matters.)

> Florian and Alan told me in a quick and objective manner why dtrace is
> a good thing, and I am glad for that information. I never stated that
> DTrace was a bad thing. 

Oh really?  You wrote:

  Come on, it's profiling. As presented by that article, it is even more
  micro optimization than one would think. What with tweaking the disk
  I/O improvements and all... If my harddisk accesses were a microsecond
  more immediate or my filesystem giving a quantum more transfer rate,
  it would be nice, but I certainly wouldn't get enthusiastic and I bet
  nobody would even notice.

So come on, yourself:  it's _not_ just "profiling" and DTrace finds
problems that are _much_ larger than "micro-optimizations" (indeed, that's
the whole damn point), and finishing the article would have told you that.

> Bryan Cantrill, I can understand that you have to defend DTrace. But
> please, PLEASE stop saying that I am a clueless moron if I wasn't even
> ranting about you, ranting about DTrace, but just about *that single
> article* and it's presentation of DTrace to me.

You were attacking more than just the article; you ended with:

  I sure hope that article is meant sarcastically. By the way, did I
  miss something or is profiling suddenly a new thing again?

You asked if you were missing something, and I replied that you were
missing plenty.  Presumably you now feel informed (if a little embarrassed),
and I think that those that you misinformed also now realize that what
you provided them was misinformation.  So as far as I'm concerned, that's
the end of that.

	- Bryan

--------------------------------------------------------------------------
Bryan Cantrill, Solaris Kernel Development.       http://blogs.sun.com/bmc
