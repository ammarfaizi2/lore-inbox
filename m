Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272386AbRH3SDu>; Thu, 30 Aug 2001 14:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272385AbRH3SDk>; Thu, 30 Aug 2001 14:03:40 -0400
Received: from otter.mbay.net ([206.40.79.2]:50192 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S272383AbRH3SD1>;
	Thu, 30 Aug 2001 14:03:27 -0400
Date: Thu, 30 Aug 2001 11:03:23 -0700 (PDT)
From: John Alvord <jalvo@mbay.net>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: lcs ethernet driver source
In-Reply-To: <Pine.LNX.4.33.0108301720190.23048-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.20.0108301102290.2203-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, David Woodhouse wrote:

> On Thu, 30 Aug 2001, Alan Cox wrote:
> 
> > > Sorry, at this point we are not allowed to publish the source code of the
> > > lcs and qeth drivers (due to the use of confidential hardware interface
> > > specifications).  We make those modules available only in binary form
> > > on our developerWorks web site.
> > 
> > Is there any plan to change this ? 
> 
> Erm, Linux on S/390 runs as a virtual machine, doesn't it? Does a lack of 
> network drivers not render it completely useless?

It can run as a virtual machine under VM. It can also run native directly
on the (LPAR) hardware.

john

