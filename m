Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSEXW2D>; Fri, 24 May 2002 18:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSEXW2C>; Fri, 24 May 2002 18:28:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3601 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312486AbSEXW2B>; Fri, 24 May 2002 18:28:01 -0400
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
To: andrea@e-mind.com (Andrea Arcangeli)
Date: Fri, 24 May 2002 23:46:13 +0100 (BST)
Cc: dank@kegel.com (Dan Kegel), akpm@zip.com.au (Andrew Morton),
        hugh@veritas.com (Hugh Dickins), cr@sap.com (Christoph Rohland),
        axboe@suse.de (Jens Axboe), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <20020524202658.GI15703@dualathlon.random> from "Andrea Arcangeli" at May 24, 2002 10:26:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BNp7-0007W7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just for reference I attached the 13 line long patch in -aa that is
> being requested to be put under this patent:

In the USA it probably is covered by that patent yes

> Now dropping this feature from tux is a matter of a few hours and it
> cannot make difference if your vfs working set fits in dcache, but
> that's not the problem. I wonder what's next, should I apply for a
> patent for the classzone algorithm in the memory balancing or is Ingo
> going to patent the O1 scheduler too? Ingo, Alan, Arjan, DaveM are so much
> worried about binary only modules, Alan even speaks about the DMCA all
> over the place, this is an order of magnitude worse, this even forbids
> you to use this tequnique despite you may invented it too from scratch
> and it's your own idea too. To make the opposite example despite IBM is

The DMCA also forbids you from using both content and ideas of your own.
If you had a clever idea about disabled access to an ebook its jail. Patents
are bad but don't trivialise the other stuff.

> a big patent producer IBM even allowed the usage of their RCU patents in
> the linux kernel (I've the paperwork under my desk and Linus should have
> received too), and other stuff donated to gcc and probably much more
> that I don't know about, IMHO exactly to avoid linux to be castrated by
> patents. So this news is totally stunning from my part.

So mail the Red Hat legal people and ask them to land similar paperwork 
under your desk if you feel you need it (remember the GPL on 'no additional
restrictions' . Lots of people are following this kind of path - RTLinux may
have been first but lots of stuff like QV30 have followed similar "GPL ok" 
type paths. 

Like it or not patents owned and controlled by the free software community
are a neccessary thing in the short term. Yes software patents need reform,
and their addition to patent law avoiding in most of the world. Code is 
speech, imagine being able to patent a book plot, or suing George Bush
because you had a patent on pro war rhetoric ?

Alan
