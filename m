Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSHBO2s>; Fri, 2 Aug 2002 10:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSHBO2s>; Fri, 2 Aug 2002 10:28:48 -0400
Received: from www.transvirtual.com ([206.14.214.140]:9486 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S314077AbSHBO2s>; Fri, 2 Aug 2002 10:28:48 -0400
Date: Fri, 2 Aug 2002 07:32:13 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Ivan Gyurdiev <ivangurdiev@attbi.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
In-Reply-To: <3D4A6D2B.2B1733D9@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0208020731520.8182-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> James Simmons wrote:
> >
> > > The following trivial patches are still missing from the kernel:
> > >
> > >        - devfs patch to fix the problem with missing virtual consoles - only 0 in
> > > /dev/vc: drivers/char/console.c
> >
> > Try out my console patch at
> >
> > http://www.transvirtual.com/~jsimmons/console.diff.gz
> >
> > Please tell me if it solves the problem. I waiting for someone to say it
> > works then I will push my BK stuff to Linus.
>
> The patch works for me.  2.5.30 with this and the compile-fix for devfs
> comes up with /dev/vc/ populated normally.

Great. I will push my stuff ot Linus now :-)

