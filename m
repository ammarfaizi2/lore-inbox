Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbTAOO6r>; Wed, 15 Jan 2003 09:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbTAOO6r>; Wed, 15 Jan 2003 09:58:47 -0500
Received: from smtp-server1.tampabay.rr.com ([65.32.1.34]:50365 "EHLO
	smtp-server1.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S265681AbTAOO6q>; Wed, 15 Jan 2003 09:58:46 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Kai Henningsen" <kaih@khms.westfalen.de>, <linux-kernel@vger.kernel.org>
Subject: RE: any chance of 2.6.0-test*?
Date: Wed, 15 Jan 2003 10:07:23 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJKEJFEDAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <8dqipJL1w-B@khms.westfalen.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Henningsen wrote:
> Well ... he did have some nice ideas. Unfortunately, they usually don't
> get palatable until someone else has worked on them.

I actually *liked* Modula-2... but I haven't used it since the very early
90s. I guess I didn't like it *that* much, huh? ;)

> If you look into Wirth's books and see that the example code in there ...
>
> * uses one(!) space indentation
> * routinely puts several statements on one line

I've got a copy of the classic "Algorithms + Data Structures = Programs"; in
it, Wirth uses four-space indentation but a proportional font. The style
isn't all that bad. Hell, I've got worse stuff in some of *my* books --
oops, shouldn't have typed that... ;)

One-space indents may very well be an artifact of idiot copy editors, and
not the author.

> * typically uses one- or two-character variable names

There is one instance when one/two-character variable names make sense:
mathematical code that directly implements numericla algorithms from the
text. In such a case, short variable names correspond directly to standard
notation; using longer names would actually obscure the correspondence
between text and code. I also don't see the point of using "array_index"
over a plain old traditional "i" in a loop.

Rarely is any coding "rule" absolute. The point is clarity; if a "goto" or
one-character identifier make sense, use'em.

For those who growl -- I think this kind of discussion *has* value in the
kernel mailing list. Kernel newbies and such can learn a great deal from
rational, calm debates among experts; if they learn, their contributions to
the kernel will be better.

Of course, note the "rational" and "calm" above, which does not apply to the
Stallman debate... ;)

I enjoy the implementation debates; they give me a better idea of where the
kernel is going, so I can figure out where to stick my oar in the waters.

--
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Professional programming for science and engineering;
Interesting and unusual bits of very free code.

