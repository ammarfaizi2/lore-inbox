Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291026AbSAaL7z>; Thu, 31 Jan 2002 06:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291032AbSAaL7o>; Thu, 31 Jan 2002 06:59:44 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:35236
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S291026AbSAaL7c>; Thu, 31 Jan 2002 06:59:32 -0500
Date: Thu, 31 Jan 2002 07:06:49 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Ro0tSiEgE <ro0tsiege@bjstuff.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel -- GCC Version
Message-ID: <20020131070649.A29290@animx.eu.org>
In-Reply-To: <055301c1a9f3$af5f73e0$ed00000a@citrix.bjstuff.com> <20020130203726.B28451@animx.eu.org> <E16W7MR-0000KN-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <E16W7MR-0000KN-00@starship.berlin>; from Daniel Phillips on Thu, Jan 31, 2002 at 03:54:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I've looked on kernel.org, in the kernel sources, it its not really clear,
> > > from what I would see. If someone could tell me exactly what are the best
> > > and/or what Linus uses versions of gcc, etc. for compiling the different
> > > kernels? (2.0/2.2/2.4/2.5) Thanks!
> > 
> > I don't recommend gcc 3.0 for kernel compiles as I had problems with it on
> > the system I tried it on.
> 
> What problem exactly?  I've had zero problems in the last 5 months.

I did get tons of warnings when compiling (I would assume everyone else
did).  But I ignored those since it says "this is obsolete"

After booting, I had so many ECC errors (I don't recall if they were
correctable or not) that I had to give up on it.

Unless debian messedup the 3.0.3 compile it didn't work for me.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
