Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290875AbSAaDSB>; Wed, 30 Jan 2002 22:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290873AbSAaDRv>; Wed, 30 Jan 2002 22:17:51 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62179 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290870AbSAaDRi>;
	Wed, 30 Jan 2002 22:17:38 -0500
Date: Wed, 30 Jan 2002 22:17:36 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Wakko Warner <wakko@animx.eu.org>, Ro0tSiEgE <ro0tsiege@bjstuff.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel -- GCC Version
Message-ID: <20020130221736.D22862@havoc.gtf.org>
In-Reply-To: <055301c1a9f3$af5f73e0$ed00000a@citrix.bjstuff.com> <20020130203726.B28451@animx.eu.org> <E16W7MR-0000KN-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16W7MR-0000KN-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Jan 31, 2002 at 03:54:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 03:54:03AM +0100, Daniel Phillips wrote:
> On January 31, 2002 02:37 am, Wakko Warner wrote:
> > > I've looked on kernel.org, in the kernel sources, it its not really clear,
> > > from what I would see. If someone could tell me exactly what are the best
> > > and/or what Linus uses versions of gcc, etc. for compiling the different
> > > kernels? (2.0/2.2/2.4/2.5) Thanks!
> > 
> > I don't recommend gcc 3.0 for kernel compiles as I had problems with it on
> > the system I tried it on.
> 
> What problem exactly?  I've had zero problems in the last 5 months.

Seconded, I've been using x86 custom-built kernels with gcc 3.0.3
for a few weeks, and IIRC the MDK kernel rpm boots for me on alpha too.

	Jeff



