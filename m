Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136587AbREEDI5>; Fri, 4 May 2001 23:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136588AbREEDIs>; Fri, 4 May 2001 23:08:48 -0400
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:47325 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136587AbREEDIm>; Fri, 4 May 2001 23:08:42 -0400
Message-ID: <3AF36DEA.86330307@home.com>
Date: Fri, 04 May 2001 20:05:14 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gordon Sadler <gbsadler1@lcisp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.5pre1 will not boot
In-Reply-To: <20010504215535.A25868@debian-home.lcisp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gordon Sadler wrote:
> 
> On Fri, May 04, 2001 at 01:28:23AM -0700, Seth Goldberg wrote:Seth Goldberg <bergsoft@home.com>
> > Gordon Sadler wrote:
> > >
> > > On Fri, May 04, 2001 at 12:43:22AM -0700, Seth Goldberg wrote:
> > > > Hi,
> > Hi,
> >
> >  Have you tried compiling ther kernel with Athlon optimiztions turned

> I've seen some others reporting some success with K6-II[I] or
> Pentium-II[I] configurations. I haven't tried it here as 2.2.19 is
> running fine for me. -) I just keep trying the new 2.4.x and reporting
> here with hopes someone will find the problem and be able to resolve it.
> There could very well be something wrong with my/our hardware. I'm at a
> loss as to why none of the developers can reproduce this? Is it possible
> none of the 'core' developers have/have access to this hardware? It
> isn't all that unusual I think.

  Yep.  I think it's just the fact that the KT133A chipset is so new
that
very few people have it.  And of the people who have it, I think a great
majority are running on distributions of Linux whose kernels are
NOT athlon optimized.  

  I'd like to ask everyone who has a KT133A to please try a 2.4.x kernel
with Athlon optimizations and let us know what percentage are displaying
this problem. 
 
  Thank you!
  --Seth
