Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSBJEJE>; Sat, 9 Feb 2002 23:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289250AbSBJEIx>; Sat, 9 Feb 2002 23:08:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64786 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289243AbSBJEIm>; Sat, 9 Feb 2002 23:08:42 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [bk patch] Make cardbus compile in -pre4
Date: Sun, 10 Feb 2002 04:07:24 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a44rls$7nh$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020209093520.XVXR9607.femail47.sdc1.sfba.home.com@there> <877kpnt1tr.fsf@fadata.bg> <E16ZZ7M-0007Y7-00@starship.berlin>
X-Trace: palladium.transmeta.com 1013314105 20251 127.0.0.1 (10 Feb 2002 04:08:25 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Feb 2002 04:08:25 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16ZZ7M-0007Y7-00@starship.berlin>,
Daniel Phillips  <phillips@bonn-fries.net> wrote:
>
>Complaining and whining are not the same thing.  Some major contributors
>have complained, that's why Linus takes this seriously.

Well, in all honesty, it's not so much that I take it seriously - it's
not as if the complaints are in any way new (or even more serious than
before - I think we had a much more serious spat a few years ago).  The
fact is, people will _always_ complain about the way things are done.

[ This very _same_ "how to maintain" flameware is not only a regular
  topic on linux-kernel, it's a regular topic on the BSD lists, on the
  gcc lists, and probably on every single bigger software project,
  whether open source or not. Why do you think there are so many
  different source control packages? ;]

But I _have_ promised Larry for the last two years or so to give BK a
chance (the last time I promised him I'd start using it as of 2.5.0),
and the discussion to a large degree just made me feel I had a good
reason to take a week off and try it out. 

I doubt bk per se will really change any of the real issues.  It will
almost certainly make it somewhat easier to merge patches from some
people, but I also suspect that those are largely the same people that I
already was pretty good at merging patches from before. 

The fundamental issue that I think I (or any human, for that matter)
work best with just a few (on the order of ten) closer contacts, and
that I want people to "network" more is pretty independent of BK or not.

However, in the long run what BK may do is to make it easier to migrate
to a "group model", where the traditional "linus tree" doesn't even
exist any more. I'm not ready to do that yet, but clearly it has to
happen at _some_ point. Nobody lives forever.

And I do like BK so far.

			Linus
