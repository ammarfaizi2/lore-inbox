Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbSJURdb>; Mon, 21 Oct 2002 13:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSJURdb>; Mon, 21 Oct 2002 13:33:31 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:40122 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261585AbSJURda>;
	Mon, 21 Oct 2002 13:33:30 -0400
Message-Id: <5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 21 Oct 2002 19:36:36 +0200
To: Thomas Molina <tmolina@cox.net>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: loadlin with 2.5.?? kernels
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210201357050.8843-100000@dad.molina>
References: <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:58 PM 10/20/2002 -0500, Thomas Molina wrote:
>On Sun, 20 Oct 2002, Mike Galbraith wrote:
>
> > At 08:17 AM 10/20/2002 -0500, Thomas Molina wrote:
> > >On Sun, 20 Oct 2002, Mike Galbraith wrote:
> > >
> > > > Greetings,
> > > >
> > > > I hadn't had time to build/test kernels since 2.5.8-pre3.  I now 
> find that
> > > > loadlin doesn't work on my box any more.  Is this a known 
> problem?  If so,
> > > > when did it quit working?  (loadlin obsolete?  other?)
> > >
> > >I'm carrying an open problem report from Rene Blokland on this issue.
> > >What version of the kernel did you try?
> >
> > Only 2.5.42.virgin, 2.5.42-mm, 2.5.43-mm and 2.5.44.virgin.  Binary search
> > pending.
>
>The report stated the problem was noted with 2.5.4x.  One of the
>developers might want to speak up as to whether finding the exact point of
>breakage is useful.

2.5.32 is the breakage point here.  I hope someone _else_ can salvage 
loadlin :)

(lions and tigers and bears - oh my GDT!)

         -Dorothy

