Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287686AbRLaXc6>; Mon, 31 Dec 2001 18:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287688AbRLaXcs>; Mon, 31 Dec 2001 18:32:48 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:11782 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S287686AbRLaXco>;
	Mon, 31 Dec 2001 18:32:44 -0500
Message-Id: <200112312332.fBVNWKBG032643@sleipnir.valparaiso.cl>
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 15:39:02 CDT."
             <20011228153902.B17774@thyrsus.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Mon, 31 Dec 2001 20:32:19 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:

[...]

> Which is why there are organized translation groups that do periodic
> translation updates for software that has registered with them.  This
> doesn't eliminate the problem, but it can keep it within manageable bounds
> that make having localizations better than not.  I deal with this regularly
> with respect to fetchmail.

Translations do suck: In Spanish, there are several "dialects" of computer
terms in common use. Get a book written in one of those, and try to make
sense on texts using another convention. Or just try to read the original
English documentation...

To do a good translation you need (a) good understanding of the source
language (enough to be able to work around bugs in the original rendering),
(b) extensive knowledge of the target language, (c) knowledge of the task
at hand. Getting all three together is hard.

Besides, stuff like comments and help messages does suffer bitrot very much
as it doesn't (much) affect functioning, translations are much worse as
they have even less exposure (== even less selective pressure to stay right).

[...]

> No, not always.  I read French, Italian, and Spanish; I can puzzle out
> technical prose in a couple of other languages.  I can read
> fetchmail's .po files and *see* that they don't suck.  

You _know_ what the English text says. To be able to make sense of a text
when you have a rather clear idea what it says is a lot easier than trying
to puzzle it out when you have no clue.

Not to say that the files in fetchmail aren OK (I looked at them myself
(German, Spanish) a while back and found little to patch).
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
