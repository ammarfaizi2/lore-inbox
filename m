Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293578AbSCEDwS>; Mon, 4 Mar 2002 22:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293577AbSCEDwJ>; Mon, 4 Mar 2002 22:52:09 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:47372 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293579AbSCEDv4>; Mon, 4 Mar 2002 22:51:56 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 4 Mar 2002 19:55:19 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Robert Love <rml@tech9.net>, Hubertus Franke <frankeh@watson.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III. 
In-Reply-To: <E16i5tL-0006NV-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0203041953480.1561-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Rusty Russell wrote:

> In message <1015293007.882.87.camel@phantasy> you write:
> > On Mon, 2002-03-04 at 17:15, Davide Libenzi wrote:
> >
> > > That's great. What if the process holding the mutex dies while there're
> > > sleeping tasks waiting for it ?
> >
> > I can't find an answer in the code (meaning the lock is lost...) and no
> > one has yet answered.  Davide, have you noticed anything?
> >
> > I think this needs a proper solution..
>
> No.  From my previous post:

Uhmm, you better comment this one.

	"please do not die while holding it, please ..."

:-)



- Davide


