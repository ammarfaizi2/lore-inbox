Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293523AbSCECuK>; Mon, 4 Mar 2002 21:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293514AbSCECuA>; Mon, 4 Mar 2002 21:50:00 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:12044 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293523AbSCECtv>; Mon, 4 Mar 2002 21:49:51 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 4 Mar 2002 18:53:13 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
In-Reply-To: <1015293007.882.87.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0203041851480.1561-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Mar 2002, Robert Love wrote:

> On Mon, 2002-03-04 at 17:15, Davide Libenzi wrote:
>
> > That's great. What if the process holding the mutex dies while there're
> > sleeping tasks waiting for it ?
>
> I can't find an answer in the code (meaning the lock is lost...) and no
> one has yet answered.  Davide, have you noticed anything?

not inside the code i saw yesterday ...


> I think this needs a proper solution..

i think so, even if it'll make things a bit more complex ...



- Davide


