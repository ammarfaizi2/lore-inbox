Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310469AbSCGTTN>; Thu, 7 Mar 2002 14:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310468AbSCGTTC>; Thu, 7 Mar 2002 14:19:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18450 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310457AbSCGTSs>; Thu, 7 Mar 2002 14:18:48 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Date: Thu, 7 Mar 2002 19:18:15 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a68edn$jjp$1@penguin.transmeta.com>
In-Reply-To: <20020305165233.A28212@fireball.zosima.org> <20020306095434.B6599@borg.org> <20020306085646.F15303@work.bitmover.com> <20020306221305.GA370@elf.ucw.cz>
X-Trace: palladium.transmeta.com 1015528710 10805 127.0.0.1 (7 Mar 2002 19:18:30 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 7 Mar 2002 19:18:30 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020306221305.GA370@elf.ucw.cz>,
Pavel Machek  <pavel@ucw.cz> wrote:
>
>So you basically give bk for free because it is good for you. What if
>it will stop being good for you ten years from now?

Guys, calm down.

A few points:

 - I certainly don't require BK use of anybody.  It makes my life
   simpler with some people (mainly the ones that tend to be maintainers
   of subsystems and send me lots of patches), but there are many
   developers who do NOT use BK, and it doesn't slow them down at all. 

   For example, see the FS patches from Al Viro: the only thing that BK
   has resulted in as far as Al is concerned is that the changelogs are
   a lot better and include his email comments. 

   And I also export my tree as regular patches, the way I always have
   (well, the actual format changed subtly, but that's purely syntactic)

 - If Larry turns to the dark side (or, as some would say, the "even
   darker side" ;) we're _still_ ok. The data isn't going anywhere, he
   can't close that down. We'd just have to export it into a new format.

   If worst comes to worst, and nobody has fixed CVS/subversion/whatever
   by then, I can even just go back to how I used to work. Nothing lost.

 - If people in the open-source SCM community wake up and notice that
   the current open-source SCM systems aren't cutting it, that's _good_. 
   But it's absolutely NOT an excuse to use them today.  Sorry.  I use
   CVS at work, and I could never use it for Linux.  I took a look at
   subversion, and it doesn't even come close to what I wanted. 

   And I personally refuse to use inferior tools because of ideology. In
   fact, I will go as far as saying that making excuses for bad tools
   due to ideology is _stupid_, and people who do that think with their
   gonads, not their brains. 

In short: nobody requires BK of anybody else.  A lot of people really
like using it, though, and it does make some things easier.  Some people
aren't convinced - David Miller is trying it out, and I haven't heard
all happy sounds from him about it. Others have taken to BK like fish to
water, and you'll pry it out of their dead cold hands.

The most productive thing people could do might be to just do a BK->CVS
gateway, if you really feel like it.  Or just go on and ignore the fact
that some people are using BK - you don't actually have to ever even
know. 

		Linus
