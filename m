Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSJ3U3m>; Wed, 30 Oct 2002 15:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264917AbSJ3U3m>; Wed, 30 Oct 2002 15:29:42 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:49299 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264915AbSJ3U3m>; Wed, 30 Oct 2002 15:29:42 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 30 Oct 2002 12:45:38 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll 0.14 ...
In-Reply-To: <Pine.LNX.4.44.0210301230350.4060-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210301243380.1446-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Linus Torvalds wrote:

>
> On Wed, 30 Oct 2002, Davide Libenzi wrote:
> >
> > Thank you very much Janet for doing performance and stability test.
> > Working with Andrew we agreed to remove the main hash table since, by
> > using in full the fcblist.c capabilities, it is not needed any more.
>
> Ok. I was just about to apply the 0.14 stuff, so please just cc me with
> the patch (and an appropriate description for the ChangeSet comment) when
> you're done with the cleanup..

Linus, it would be good if you could wait a couple of days so that cleanup
and regression testing is completed. Friday looks good for me ...



- Davide


