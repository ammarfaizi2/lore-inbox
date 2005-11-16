Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVKPCBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVKPCBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 21:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVKPCBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 21:01:43 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:37016 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S965164AbVKPCBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 21:01:43 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Date: Wed, 16 Nov 2005 02:01:34 +0000
User-Agent: KMail/1.9
Cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
References: <20051115210459.GA11363@kroah.com> <20051116011032.GA16604@kroah.com> <2cd57c900511151746k341b93a3u@mail.gmail.com>
In-Reply-To: <2cd57c900511151746k341b93a3u@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160201.34149.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 01:46, Coywolf Qi Hunt wrote:
> 2005/11/16, Greg KH <greg@kroah.com>:
> > On Wed, Nov 16, 2005 at 01:23:48AM +0100, Adrian Bunk wrote:
> > > > Introduction
> > > > ------------
> > > >...
> > > > The kernel is written mostly in C, with some architecture-dependent
> > > > parts written in assembly. A good understanding of C is required for
> > > > kernel development.  Assembly (any architecture) is not required
> > > > unless you plan to do low-level development for that architecture. 
> > > > Though they are not a good substitute for a solid C education and/or
> > > > years of experience, the following books are good for, if anything,
> > > > reference: - "The C Programming Language" by Kernighan and Ritchie
> > > > [Prentice Hall] - "Practical C Programming" by Steve Oualline
> > > > [O'Reilly]
> > > >  - "Programming the 80386" by Crawford and Gelsinger [Sybek]
> > > >  - "UNIX Systems for Modern Architectures" by Curt Schimmel [Addison
> > > > Wesley]
> > >
> > > "UNIX Systems for Modern Architectures" is a good book about cpu
> > > caches.
> > >
> > > But it's hardly interesting for the average driver writer and even less
> > > a book about C programming.
> >
> > True, I've removed it now, thanks.
>
> Also why you have to mention those non-free books here? I don't read
> them and I live OK. There's plenty of free information one can always
> find on the net.
[snip]

Some people just prefer a hard copy (which obviously can't be produced for 
nothing) instead of an on-line reference. I think google.com is already a 
fairly obvious (almost instinctive) answer to any question these days.

Books vary in quality and comprehensiveness, recommendations are incredibly 
useful for somebody faced with buying into a subject he has no real knowledge 
of.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
