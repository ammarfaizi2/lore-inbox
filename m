Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbTLLJ1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 04:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTLLJ1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 04:27:05 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:9929 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S264512AbTLLJ1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 04:27:00 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Fri, 12 Dec 2003 03:27:30 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312112345400.3805-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10312112345400.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312120327.30814.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 December 2003 01:56, Andre Hedrick wrote:
> Rob,
>
> I must admit when I jumped into this thread late, I said I was a little
> chilly here in Northern California.  I am toasty warm now and look like
> "Buckwheat" (just not on the top cause the hair is thin).
>
> The up side of the roasting is you have exposed yourself as a serious pool
> of knowledge.  The down side for you is class is in session, and if
> nothing else I would like to here all the various positions and reviews
> you have observer, contributed, and blah blah ...
>
> TMF is not an easy place to express an opinion.
>
> My butt is in the chair to listen if class is in session :-)

Sheesh, I'm not an expert on this, but I'm happy to share my ignorance.  Just 
keep in mind, IANAL. :)

The place I started is http://www.faqs.org/faqs/law/copyright/faq/
which is pretty darn stale now (it's ten years old, it predates the sony bono 
copyright extension act, the DMCA, and a bunch of other stuff).  So don't 
take is as an authority on any specifics of the law, but I found it to be a 
great introduction to the basic concepts, and I'd guess it still is.

MIT has a similar FAQ here, but it's not nearly as thorough:

http://web.mit.edu/copyright/faq.html

And the next step (more authoritative/recent, but less detailed and newbie 
friendly) would be here:

http://www.copyright.gov/faq.html

What else...  Understanding that copyright law is NOT the same as contract 
law, trademark law, patent law, or the nebulous mess that is trade secrets.  
(This is why stallman objects to the term "intellectual property", since 
there are several distinct islands that do not quite form a whole.  I 
personally find his perfectionist attitude to be unhelpful dealing with the 
real world, but this is nothing new...)

If you just understand the difference between a copyright and a license, 
you're ahead of most people.  Dual licensing, who can issue a license, what 
happens when license terms are not compatable, etc...  It's also probably a 
good idea to try to understand the first sale doctrine and fair use.  These 
are good fundamental limits on copyright.  (Trying to figure out how they 
apply online gives professional lawyers headaches, but keep in mind that the 
law is all about analogies.  Half of what lawyers do is find good analogies 
to convince a judge "this situation is just like X" while the other lawyer 
tries to convince them it's just like Y...)

You know, you could probably grab a business law textbook from your local 
community college's bookstore.  It'll have chapters on this written by 
somebody who knows what they're talking about.

Beyond that... Understanding what the law currently _is_ takes a bit of work.  
It's almost like trying to follow new kernel versions.  Some of the lawyers I 
know occasionally send me articles from findlaw's news section 
(news.findlaw.com), which I don't have time to follow myself.  Typing "gpl" 
into its news search thingy would almost certainly be interesting. :)

Oh, and don't take anything you find as an absolute.  Precedent isn't a 
guarantee, and what the law actually says can be bent amazingly with enough 
money (OJ Simpson, Dmitry Skylarov...)  You may find some marvelous thing 
that's in the wrong jurisdiction, etc.

This is a hobby every bit as complicated as programming.  When it comes to the 
law I strive to be a "power user", and even that's work...

P.S.  I'd guess that the right place to ask questions on all this is 
www.groklaw.com.  It can best be described as the geek law equivalent of 
slashdot.  It focuses on the SCO mess, and lots of lawyers hang out there.  
(Their standard disclaimer is IAALBIANYL:  I Am A Lawyer, But I Am Not Your 
Lawyer.)

Rob
