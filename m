Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbTASIrH>; Sun, 19 Jan 2003 03:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbTASIrG>; Sun, 19 Jan 2003 03:47:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:21659 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265650AbTASIrG>;
	Sun, 19 Jan 2003 03:47:06 -0500
Date: Sun, 19 Jan 2003 00:57:37 -0800
From: Andrew Morton <akpm@digeo.com>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59mm2 BUG at fs/jbd/transaction.c:1148
Message-Id: <20030119005737.5d0b8a7e.akpm@digeo.com>
In-Reply-To: <5.1.1.6.2.20030119090404.00c82030@pop.gmx.net>
References: <5.1.1.6.2.20030119084031.00c81180@pop.gmx.net>
	<20030118002027.2be733c7.akpm@digeo.com>
	<5.1.1.6.2.20030119084031.00c81180@pop.gmx.net>
	<5.1.1.6.2.20030119090404.00c82030@pop.gmx.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2003 08:56:01.0327 (UTC) FILETIME=[973FCBF0:01C2BF98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> At 12:05 AM 1/19/2003 -0800, Andrew Morton wrote:
> >Mike Galbraith <efault@gmx.de> wrote:
> > >
> > > Greetings,
> > >
> > > I got the attached oops upon doing my standard reboot sequence SysRq[sub].
> > >
> > > fwiw, I was fiddling with an ext2 ramdisk just prior to poking buttons.
> > >
> >
> >You using data=journal?
> 

data=journal is sick in 2.5, although this is not the crash which I have seen
it exhibit.

On my todo list.
