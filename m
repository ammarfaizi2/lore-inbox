Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbTARLeO>; Sat, 18 Jan 2003 06:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbTARLeO>; Sat, 18 Jan 2003 06:34:14 -0500
Received: from khms.westfalen.de ([62.153.201.243]:26519 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S264683AbTARLeK>; Sat, 18 Jan 2003 06:34:10 -0500
Date: 18 Jan 2003 12:12:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8e5ESb8Hw-B@khms.westfalen.de>
References: <FKEAJLBKJCGBDJJIPJLJKEJFEDAA.scott@coyotegulch.com>
Subject: Re: any chance of 2.6.0-test*?
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <FKEAJLBKJCGBDJJIPJLJKEJFEDAA.scott@coyotegulch.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scott@coyotegulch.com (Scott Robert Ladd)  wrote on 15.01.03 in <FKEAJLBKJCGBDJJIPJLJKEJFEDAA.scott@coyotegulch.com>:

> Kai Henningsen wrote:
> > Well ... he did have some nice ideas. Unfortunately, they usually don't
> > get palatable until someone else has worked on them.
>
> I actually *liked* Modula-2... but I haven't used it since the very early
> 90s. I guess I didn't like it *that* much, huh? ;)

Stuck shift key syndrome.

> > If you look into Wirth's books and see that the example code in there ...
> >
> > * uses one(!) space indentation
> > * routinely puts several statements on one line
>
> I've got a copy of the classic "Algorithms + Data Structures = Programs"; in
> it, Wirth uses four-space indentation but a proportional font. The style
> isn't all that bad. Hell, I've got worse stuff in some of *my* books --
> oops, shouldn't have typed that... ;)
>
> One-space indents may very well be an artifact of idiot copy editors, and
> not the author.

I think I've actually seen that in more than one Wirth book, but it's been  
quite a while.

> > * typically uses one- or two-character variable names
>
> There is one instance when one/two-character variable names make sense:
> mathematical code that directly implements numericla algorithms from the
> text. In such a case, short variable names correspond directly to standard
> notation; using longer names would actually obscure the correspondence
> between text and code. I also don't see the point of using "array_index"
> over a plain old traditional "i" in a loop.

B-trees is the example I most remember. I once carefully typed his source  
in, then spent several days reformatting the source and putting in  
sensible variable names; then when that source was finally readable, I  
decided that several things in there needed doing differently - I don't  
remember the details, but IIRC some parameter/result passing stuff was  
rather poorly thought out.

If *I* were an IT prof and a student handed me code like that, I'd be  
sorely tempted to give that a "fail". Or at the very least a "just barely  
passed". Publishing it in a book means the editor fell down on his job.

> Rarely is any coding "rule" absolute. The point is clarity; if a "goto" or
> one-character identifier make sense, use'em.

And so I do.

> For those who growl -- I think this kind of discussion *has* value in the
> kernel mailing list. Kernel newbies and such can learn a great deal from
> rational, calm debates among experts; if they learn, their contributions to
> the kernel will be better.

That part is fine - what's bad is obvious newbies insisting they know  
better, two dozen times a day, and the rest of the world not treating them  
as the obvious kooks they are. Those are the painful parts of this thread.

> Of course, note the "rational" and "calm" above, which does not apply to the
> Stallman debate... ;)

Let's just say that my ideas about successful public relations (note I'm  
not talking about programming here) seem to be diametrally opposite to  
those of rms, and leave it at that. (Ok, I feel I need to add that while I  
don't personally like esr, his PR efforts seem to have been a lot more  
successful - and I completely reject the notion that Open Source anything  
more than a different name for Free Software. A rose by any other name  
...)

> I enjoy the implementation debates; they give me a better idea of where the
> kernel is going, so I can figure out where to stick my oar in the waters.

Similar here.


MfG Kai
