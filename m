Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293559AbSCERUm>; Tue, 5 Mar 2002 12:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293515AbSCERUd>; Tue, 5 Mar 2002 12:20:33 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:54793 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293513AbSCERUU>; Tue, 5 Mar 2002 12:20:20 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 5 Mar 2002 09:23:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Robert Love <rml@tech9.net>, Hubertus Franke <frankeh@watson.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III. 
In-Reply-To: <E16i8AD-0007Sb-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0203050921300.1475-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0203041953480.1561-100000@blue1.dev.mcafeelabs.com> y
> ou write:
> > On Tue, 5 Mar 2002, Rusty Russell wrote:
> >
> > > In message <1015293007.882.87.camel@phantasy> you write:
> > > > On Mon, 2002-03-04 at 17:15, Davide Libenzi wrote:
> > > >
> > > > > That's great. What if the process holding the mutex dies while there're
> > > > > sleeping tasks waiting for it ?
>
> I don't see that.  Your data, your program, your funeral, yes?
>
> Want to autoclean the lock?  There are many ways to do this in
> userspace.  For most cases, the problem is "and then what"?

I tried hard to remember cases where fetures of IPC sems have been handy
to me but i failed.

	*as designed*



- Davide


