Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbTHaChH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 22:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTHaChH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 22:37:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65444 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262394AbTHaChE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 22:37:04 -0400
Date: Sat, 30 Aug 2003 23:39:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: Norberto BENSA <nbensa@gmx.net>
Cc: "J.A. Magallon" <jamagallon@able.es>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check_gcc for i386
In-Reply-To: <200308302020.45564.nbensa@gmx.net>
Message-ID: <Pine.LNX.4.44.0308302336440.20519-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Aug 2003, Norberto BENSA wrote:

> Marcelo Tosatti wrote:
> > On Sun, 31 Aug 2003, J.A. Magallon wrote:
> > > +CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
> > >  endif
> > >
> >
> > OK, I forgot what that does. Can you please explain in detail what
> > check_gcc does.
> 
> Hmmm... Parhaps it checks if gcc supports those command line parameters (just 
> a wild guess)? Marcelo, do you need a break? :-)

Actually, I do need a break, thanks. But my worries were about the new
flags doing nasty things.

See?

Well, I indeed need to sleep: Good night. 

