Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317418AbSFCQrm>; Mon, 3 Jun 2002 12:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317419AbSFCQrl>; Mon, 3 Jun 2002 12:47:41 -0400
Received: from pc132.utati.net ([216.143.22.132]:14757 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S317418AbSFCQrj>; Mon, 3 Jun 2002 12:47:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: business models [was patent stuff]
Date: Mon, 3 Jun 2002 06:49:15 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205290321.UAA01482@adam.yggdrasil.com> <1022678126.9255.182.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020603171808.647527BD@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 May 2002 09:15 am, Alan Cox wrote:

> I would worry much more about the million odd patents IBM have, where
> IBM have no general statement of this nature than the Red Hat ones.
> Perhaps once the Red Hat statement is published IBM can be persuaded to
> show willing ?

I'm is off dealing with patents from Sun, Sony, Apple, and Microsoft.  Their 
patent portfolio is like a nuclear arsenal: mutual assured destruction, so 
nobody actually uses their stockpile.

The down side of the GPL language handling patents implies that they more or 
less put a patent into the public domain.  I.E:

> Finally, any free program is threatened constantly by software patents. We 
> wish to avoid the danger that redistributors of a free program will 
> individually obtain patent licenses, in effect making the program 
> proprietary. To prevent this, we have made it clear that any patent must be 
> licensed for everyone's free use or not licensed at all. 

However, looking at the text of the license, it seems that it might be 
possible to issue a patent license allowing use for the patent only in GPL 
licensed programs.  (Thus IBM could issue a blanket statement saying that any 
of its patents may be used in GPL code, without necessarily unilaterally 
disarming itself with regards to Sony's patents.)

Opinions from Lessig and Stallman and a few random lawyers would be required 
to really get the issue decently clarified, though.  (It would be best if 
such a license could be a one-paragraph addendum to the GPL itself, perhaps a 
GPL V2.1?)  Using the GPL as a patent pool would be extremely useful to free 
software in the long run...

> > 	More importantly, licensing patents only for pure GPL'ed use
> > is unlikely to become a norm that you can expect broad adoption of
> > in free software businesses, as many of them tend to be proponents of
> > slightly different copying permissions.  If we have a bunch of patents
> > licensed for GPL-only, another bunch for MPL-only, another bunch for
> > pure-BSD only, then the patent proliferation that I described
> > yesterday will still probably occur.
>
> I would agree to an extent. Certainly purely GPL is excluding stuff
> which has identical 'all of package' rules like db3, Qt free editions,
> and much of KDE.

That said, a GPL-only patent license looks like the minimal set of permission 
grants required for a patent to be compatable with the GPL, and such a setup 
does start to turn the GPL into a patent pool anyone can join, which isn't 
entirely a bad thing...

And the existence of a less permissive license doesn't prevent the existence 
of a MORE permissive license.  (Dual GPL/BSD, for example...)

The whole patent issue is largely a matter of big fish using patent pools to 
exclude small fish.  A free software patent pool has been proposed repeatedly 
but never had the critical mass to get off the ground.  (On a related note, I 
entirely understand Red Hat seeking defensive patents due to the mexican 
standoff nature of the modern patent landscape, but hope they plan to use 
them wisely for the good of the community...)

Rob
