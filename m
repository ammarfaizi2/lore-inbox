Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263979AbSJTSxQ>; Sun, 20 Oct 2002 14:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSJTSxQ>; Sun, 20 Oct 2002 14:53:16 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:43138 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S263979AbSJTSxP>;
	Sun, 20 Oct 2002 14:53:15 -0400
Date: Sun, 20 Oct 2002 13:58:39 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Mike Galbraith <efault@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: loadlin with 2.5.?? kernels
In-Reply-To: <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0210201357050.8843-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Mike Galbraith wrote:

> At 08:17 AM 10/20/2002 -0500, Thomas Molina wrote:
> >On Sun, 20 Oct 2002, Mike Galbraith wrote:
> >
> > > Greetings,
> > >
> > > I hadn't had time to build/test kernels since 2.5.8-pre3.  I now find that
> > > loadlin doesn't work on my box any more.  Is this a known problem?  If so,
> > > when did it quit working?  (loadlin obsolete?  other?)
> >
> >I'm carrying an open problem report from Rene Blokland on this issue.
> >What version of the kernel did you try?
> 
> Only 2.5.42.virgin, 2.5.42-mm, 2.5.43-mm and 2.5.44.virgin.  Binary search 
> pending.

The report stated the problem was noted with 2.5.4x.  One of the 
developers might want to speak up as to whether finding the exact point of 
breakage is useful.


