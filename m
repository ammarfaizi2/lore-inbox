Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSGTEcT>; Sat, 20 Jul 2002 00:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSGTEcT>; Sat, 20 Jul 2002 00:32:19 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:12675 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317352AbSGTEcR>;
	Sat, 20 Jul 2002 00:32:17 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new module format 
In-reply-to: Your message of "Fri, 19 Jul 2002 11:31:24 +0200."
             <Pine.LNX.4.44.0207191128030.28515-100000@serv> 
Date: Sat, 20 Jul 2002 14:13:46 +1000
Message-Id: <20020720043607.20CEA419C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0207191128030.28515-100000@serv> you write:
> Hi,
> 
> On Fri, 19 Jul 2002, Rusty Russell wrote:
> 
> > 	I've started updating my in-kernel module loader patches for 2.5.26.
> > I'll send you a mail when it's done.
> 
> The more I think about it, the more I like the idea to go into the other
> direction. Most of the module information (e.g. symbols, dependencies)
> stored in the kernel can be as well managed in userspace.

You might be right.  All kinds of things can be pushed into userspace:
code will tell.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
