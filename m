Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWI1JWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWI1JWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbWI1JWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:22:19 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:15327 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1751664AbWI1JWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:22:18 -0400
Date: Thu, 28 Sep 2006 11:22:27 +0200
From: DervishD <lkml@dervishd.net>
To: Esteban Barahona <esteban.barahona@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Creative Commons as an example of a simple license
Message-ID: <20060928092227.GD28029@DervishD>
Mail-Followup-To: Esteban Barahona <esteban.barahona@gmail.com>,
	linux-kernel@vger.kernel.org
References: <loom.20060928T075159-494@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <loom.20060928T075159-494@post.gmane.org>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Esteban :)

 * Esteban Barahona <esteban.barahona@gmail.com> dixit:
> apparently I "have lines longer than 80 characters" so I have to
> post like this: http://www.zensui.org/CC/about_GPLv3.html

    Unfortunately, your HTML file also have lines longer than 80
characters, that's probably why you couldn't post your original
message.

    Anyway, I'll try to answer some of it here, quoting from the
reformatted text:

> I agree. I've started to read GPLv2 and the draft of GPLv3, but
> they're so plain *boring* to read that I never finish reading. The
> 3 clause BSD license is more straight-forward (although too
> permissive). But of all the Free and Open Culture Licenses that
> I've read, the Creative Commons is IMHO the simpler and so the
> best.

    Unfortunately, this is not as simple. I'm not a lawyer, so take
my words with a lot of salt... A simpler license is simpler to
understand, but that doesn't make it the best. The best license
should achieve all your goals. If your goals are simplicity, then the
simpler license is the best. Otherwise...

    In software, probably the goals are different. _MY_ goals are: if
you take my work and you modify it, share the modifications. I don't
even really care about if the one who makes the derived work credits
me. Of course, I like to see my name as the original author, but
that's not my main goal. My main goal is: if you take, please give.
For that, something like GPLv2 is ideal, but other people may (and
really should!) think very differently.

    This said, thinking that the simpler a license, the better it is,
is plain wrong. It like saying that the simpler the code, the best.
Sometimes the best code is also simple, but that's not common.

> Spanish is my native language, and reading legaleze (laws, as sets
> of restrictions enforced by a supposed "authority") in English is
> too boring; and even more if I'm chosing the license for my (art,
> design, creative) works.

    This is something that I fully understand because Spanish is too
my mother tongue and I find VERY boring to read legalese O:)

> IMHO one of the strenghts of the Creative Commons license is that
> it doesn't exclude anyone. There's a subset of
> permissions/restrictions (some mutually exclusive, like "non
> derivatives" and "share alike" in which "share alike" doesn't even
> apply) which each individual copyright owner choses.

    I find Creative Commons a very good license, and I encourage its
use, but I'm still not sure if it suits software. Software has its
own subtleties and problems, and I don't think that CC licenses
protects it correctly. For example (and please correct me if I'm
wrong because I'm very interested in this issue), if you release some
software with a too-free license (something like "do whatever you
want with my code but respect my name as original author"), some evil
company can take the software, modify it, sell it and RELICENSE it as
long as they say "Oh, BTW, the original author was Mr. Poor Bastard".
After that you won't be able to take the software, modify it and
redistribute it because you will be probably violating THEIR license.
GPLv2 protects against that, and I'm afraid that CC doesn't unless
you choose a more restrictive subset of rights, which in turn may
make impossible for others to modify and redistribute the work.
Moreover, I want my license to be "viral", in the sense that the
modifications are distributed in the same terms as my original
software, and I don't know if CC allows for this :?????

> Altough there's an implicit free/open/sharing culture philosophy,
> the license itself is a way of expressing clearly the (c) owner's
> permissions and/or restrictions. Nothing less, nothing more.

    Don't forget that CC is written too in "legalese", otherwise it
won't be enforceable in court. The fact that they provide human
readable forms doesn't change the fact that if you live in this
crappy word you have to deal with lawyers :((

> Current GPLv3 draft and the discussion between Open Source and Free
> Software movements deals with the legaleze and minutae... which
> IMHO few creative content producers (I'm including artists and
> developers in the same "box" for the sake of discussion) people
> care to deal with.

    I can't speak for artist, and although I can't speak for
developers either, what I've seen in the software world is that many
software authors care about license. I *do* care about the license I
choose for my software, and I think that any developer whose software
may be interesting to other developers and not only to end users do
care too about licensing. Please notice that I'm not saying they care
about the legalese, but about the license. They probably hire a
lawyer to make sure the license is enforceable.

> A simple software license (and as such understandable) may end (I
> hope) the discussion between "Free" and "Open" movements. The
> license can even be modular to provide with flexibility (like the
> Creative Commons license), but it's only a license and should be
> treated as such. The personal motivations,
> philosophy/ideology/religion, etc are subjective and as such
> shouldn't be "permated" (don't know if that's the word) into an
> objective legal contract.

    I'm with you in that maybe a modular license would be perfect, as
long as the modules are few and more or less orthogonal, so they can
be defended in court if the need arises. But I'm not with you in that
a simpler and more understandable license would help. You don't have
to fully understand the license. I don't have to understand it,
either. A judge must understand it. Obviously, the better you and me
understand the license, the better choice we will be making, but
that's a matter of re-reading the license, consult lawyers, taking
advice, etc. Myself, I wouldn't rely on a license I can understand at
first reading XD

> The problem with subjective clauses is that it makes the license
> (and the combination of other licenses) more complex... and that is
> counter-productive (license's incompatibility). Software licenses
> has enough oddities to deal with because of it's nature (a plain
> "pixel matrix" is easier to understand... it can be explained to
> anyone without using technical terms) and adding such subjective
> clauses and discussion is IMO self-defeating.

    You're probably right, I don't know. I think that the entire
GPLv3 issue is very important, and I don't like a license with an
agenda, but I must confess that I haven't read the GPLv3 latest draft
enought times to fully understand it or its consequences. In fact,
I've relicensed my software to GPLv2-only until I fully understand
the new license. I've considered relicensing to CC, but when I tried
I didn't find any subset of rights that achieve what I wanted, and
GPLv2 fulfilled my needs. Moreover, I understand GPLv2 (or at least,
I think I understand enough of it to have made the more sensible
decision for my software) and its consequences, while I'm not sure
about the consequences of adopting a CC license. Maybe in the
future...

    BTW, if you want feel free to write me privately if you want to
continue speaking about this issue and you find more comfy to do it
in Spanish ;)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
