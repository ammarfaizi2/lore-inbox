Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263216AbSJ2XJv>; Tue, 29 Oct 2002 18:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSJ2XJv>; Tue, 29 Oct 2002 18:09:51 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:49302 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263216AbSJ2XJu>; Tue, 29 Oct 2002 18:09:50 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 15:25:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hanna Linder <hannal@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@digeo.com>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <54690000.1035932769@w-hlinder>
Message-ID: <Pine.LNX.4.44.0210291524210.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Hanna Linder wrote:

> --On Tuesday, October 29, 2002 13:41:34 -0800 Davide Libenzi <davidel@xmailserver.org> wrote:
> >>
> >> > Hanna, is it possible for you guys to cleanup ephttpd and make it an
> >> > example program for sys_epoll ?
> >>
> >> You mean for the man page? Sure, I will look into it.
> >
> > Not only for the man page, like a kind-of-reference possible usage ...
>
>
> Would it make sense to put sys_epoll examples in the Documentation
> directory?

I don't really know ... epoll does not have kernel services. IMHO this is
more user space documentation.



- Davide


