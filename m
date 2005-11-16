Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbVKPBqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbVKPBqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVKPBqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:46:05 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:35682 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965155AbVKPBqE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:46:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PA5HZ9tKq5PPeKIVtZxnC5uunGPBP8Owp6DPQcvPgNLYHyFEQiC+6POJBn63Nfqm7dz9IomIqxYFRyl03gFrJmIrbpebyX0sIgjhSPM2uvHTnHVL2myI2++1E+MmeEtxLoUJQLrQXG2iVecxUVz2Bm4xiz5XPaQMtGshbUhXShQ=
Message-ID: <2cd57c900511151746k341b93a3u@mail.gmail.com>
Date: Wed, 16 Nov 2005 09:46:02 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Cc: Adrian Bunk <bunk@stusta.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051116011032.GA16604@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051115210459.GA11363@kroah.com>
	 <20051116002348.GL5735@stusta.de> <20051116011032.GA16604@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/16, Greg KH <greg@kroah.com>:
> On Wed, Nov 16, 2005 at 01:23:48AM +0100, Adrian Bunk wrote:
> > > Introduction
> > > ------------
> > >...
> > > The kernel is written mostly in C, with some architecture-dependent
> > > parts written in assembly. A good understanding of C is required for
> > > kernel development.  Assembly (any architecture) is not required unless
> > > you plan to do low-level development for that architecture.  Though they
> > > are not a good substitute for a solid C education and/or years of
> > > experience, the following books are good for, if anything, reference:
> > >  - "The C Programming Language" by Kernighan and Ritchie [Prentice Hall]
> > >  - "Practical C Programming" by Steve Oualline [O'Reilly]
> > >  - "Programming the 80386" by Crawford and Gelsinger [Sybek]
> > >  - "UNIX Systems for Modern Architectures" by Curt Schimmel [Addison Wesley]
> >
> >
> > "UNIX Systems for Modern Architectures" is a good book about cpu caches.
> >
> > But it's hardly interesting for the average driver writer and even less
> > a book about C programming.
>
> True, I've removed it now, thanks.

Also why you have to mention those non-free books here? I don't read
them and I live OK. There's plenty of free information one can always
find on the net.

>
> > LDD (as you might have heard, it's also available online for free ;-) )
> > and the book by Robert Love are good starting points for learning kernel
> > programming, and they should IMHO be listed here.
>
> But that's what the Documentation/kernel-docs.txt file has in it.  I
> don't want to get into judging which kernel books go into this file, as
> people might think I am a bit biased :)
>
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
