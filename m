Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283265AbSAAUB5>; Tue, 1 Jan 2002 15:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283723AbSAAUBs>; Tue, 1 Jan 2002 15:01:48 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:23759 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283265AbSAAUBh>; Tue, 1 Jan 2002 15:01:37 -0500
Date: Tue, 1 Jan 2002 13:01:23 -0700
Message-Id: <200201012001.g01K1NF15702@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Larry McVoy <lm@bitmover.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        samson swanson <intellectcrew@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: a great C++ book?
In-Reply-To: <20020101104331.F4802@work.bitmover.com>
In-Reply-To: <20020101041111.29695.qmail@web14310.mail.yahoo.com>
	<Pine.LNX.4.43.0201011214560.7188-100000@waste.org>
	<20020101104331.F4802@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:
> On Tue, Jan 01, 2002 at 12:25:10PM -0600, Oliver Xymoron wrote:
> > On Mon, 31 Dec 2001, samson swanson wrote:
> > 
> > > hello again,
> > >
> > > i ask this group because i trust in your intellect.
> > >
> > > For a beginner to C++ what is your favorite book? A
> > > book that goes in depth of teaching the language.
> > > remeber i am  a beginner, new to c++.
> > 
> > If you already know C well, Bjarne Stroustrup's "The C++ Programming
> > Language" is decent. If not, start with Kernighan and Ritchie's "The C
> > Programming Language". Put the two next to each other and you might gain
> > some insight into the creeping horror that modern C++ has become.
> 
> It's hard to explain a love/hate relationship with C++.  I think
> many systems programmers come to a point where they can "speak" C++
> and do so in design conversations all the time, talking about the
> "objects" and the "methods", etc.  But they program in C.
>
> This sends a somewhat mixed message to the casual observer who might
> think that one language or the other is "better".  The reality is
> that you want tp program in a fairly object oriented way but you
> also want to avoid "the creeping horror that modern C++ has
> become.".

An extract from the FAQ about C++: http://www.tux.org/lkml/#s1-4

"My personal view is that C++ has it's merits, and makes
object-oriented programming easier. However, it is a more complex
language and is less mature than C. The greatest danger with C++ is in
fact it's power. It seduces the programmer, making it much easier to
write bloatware. The kernel is a critical piece of code, and must be
lean and fast. We cannot afford bloat. I think it is fair to say that
it takes more skill to write efficient C++ code than C code. Not every
contributer to the linux kernel is an uber-guru, and thus will not
know the various tricks and traps for producing efficient C++ code."

Object-oriented programming is a good tool. One of many. But it
shouldn't be a religion, nor do you need to write in C++ to make use
of it. A good example of object-oriented programming done in C is the
Xt toolkit.

> Makes you wonder what would happen if someone tried to design a
> minimalistic C++, call it the "M programming language", have be
> close to C with the minimal useful parts of C++ included.

I'm sure lots of people have thought about this. A friend of mine and
I sat down once and did a rough design for the "K" language, which was
supposed to be "exactly like C, only better". Basically, we wanted to
cherry-pick the good bits of C++, plus add some other things. As
usual, lack of time is the enemy. Besides, what's point unless it gets
widely used, and the chance of that is small.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
