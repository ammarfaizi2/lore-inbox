Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSJUDT2>; Sun, 20 Oct 2002 23:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264710AbSJUDT2>; Sun, 20 Oct 2002 23:19:28 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:30855 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264706AbSJUDT2>; Sun, 20 Oct 2002 23:19:28 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 20 Oct 2002 20:34:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll ...
In-Reply-To: <3DB34F39.C2923F7B@digeo.com>
Message-ID: <Pine.LNX.4.44.0210202030090.1423-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Andrew Morton wrote:

> Davide Libenzi wrote:
> >
> > Per Linus request I implemented a syscall interface to the old /dev/epoll
> > to avoid the creation of magic inodes inside /dev.
>
> >From a (very) quick read:

[ lots of required fixes ]

The new patch ( 0.3 ) with the fixes Andrew suggested is available here :

http://www.xmailserver.org/linux-patches/nio-improve.html#patches




- Davide


