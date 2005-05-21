Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVEUX7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVEUX7p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 19:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVEUX7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 19:59:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64520 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261697AbVEUX7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 19:59:33 -0400
Date: Sun, 22 May 2005 01:59:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: omb@bluewin.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050521235928.GL4489@stusta.de>
References: <200505201345.15584.pmcfarland@downeast.net> <428E70B3.1050007@khandalf.com> <20050521073826.GR5112@stusta.de> <428F644A.3000801@khandalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <428F644A.3000801@khandalf.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 06:39:38PM +0200, Brian O'Mahoney wrote:
> 
> 
> Adrian Bunk wrote:
> > 
> > In my personal experience, the Solaris packages are quite usable.
> > 
> > I don't claim they were perfect, but do you have compelling reasons why 
> > you call the people who developed it "idiots"?
> 
> The point I made was that SUN do support/use the GNU toolchain
> internally, and everyone has used GNU on SUN since they started to
> charge for the Solaris C compiler in the 80's. They also have RPM
> and it is only recently they integrated Perl and I object to this
> attitude whether it comes from SUN or MicroSoft
> 
> As to pkg* just look at what is missing/deficient -v- any OpenSource
> tool, which was desingned by those that were going to _use_ it not
> just tick a check box

It was nice if you would name the points why you think Solaris packages 
are that inferior to e.g. RPM or dpkg packages.

E.g. if you know a standard way how to get the same functionality as 
request/pkgask in Solaris packages for RPM packages I'd be glad to hear 
about.

Not that I'd claim that Solaris packages were perfect.

Some examples:
- Solaris packages don't support upgrades of packages.
- I know in neither RPM nor Solaris packages a mechanism similarly 
  powerful to the dpkg diversions.

I'd personally say dpkg is the best of this three package formats. But I 
have to admit that RPM is the one amongst them I know the least, and you 
can correct my statements regarding RPM if you know better.

But altogether, I don't see any of these three package formats being 
hopelessly inferior to the other two.

> It is typical of the period in which AT&T had more Marketeers and Lawers
> working on Unix that there were developers. These were the guys who
> helped to start the Unix wars.

You said:

  Finally SUN should move from the pkg* abortion, written by idiots
  at AT&T, some 25 years ago to RPM.

If you call people "idiots", you should at least be able to give some 
hard facts where exactly they should have done something different based 
on the knowledge that was available at the time they did it.

And it seems you also missed that the Solaris package format has evolved 
over the years.

> mit freundlichen Grüßen, Brian.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

