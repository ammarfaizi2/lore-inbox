Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUJEUe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUJEUe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUJEUe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:34:57 -0400
Received: from spirit.analogic.com ([208.224.221.4]:24585 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S264991AbUJEUey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:34:54 -0400
From: "Johnson, Richard" <rjohnson@analogic.com>
Reply-To: "Johnson, Richard" <rjohnson@analogic.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       "Johnson, Richard" <rjohnson@analogic.com>,
       linux-kernel@vger.kernel.org
Date: Tue, 5 Oct 2004 16:38:48 -0400 (EDT)
Subject: Re: Linux-2.6.5-1.358 and Fedora
In-Reply-To: <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.53.0410051635370.3240@quark.analogic.com>
References: <1097004565.9975.25.camel@laptop.fenrus.com>
 <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Jesper Juhl wrote:

> On Tue, 5 Oct 2004, Arjan van de Ven wrote:
>
> > If Richard overwrote his modules anyway he must have hacked the Makefile
> > himself to deliberately cause this, at which point... well saw wind
> > harvest storm ;)
> >
> While I lack specific Fedora knowledge and thus can't provide exact
> details for it I'd say it should still be pretty simple to recover. On
> Slackware I'd simply boot a kernel from the install CD and tell it to
> mount the installed system on my HD, then you'll have a running system and
> can easily clean out the broken modules etc and install the original ones
> from your CD and be right back where you started in 5 min. Surely
> something similar is possible with Fedora, reinstalling from scratch (as
> he said he did) seems like massive overkill to me.
>
>
> --
> Jesper Juhl
>


Yeh?  There is no place to get replacement modules from. They are
somewhere on some RPM on one of the CDs, with no way to know. It's
not like you could tar everything from the current root file-system.

They don't exist in the root file-system, which is a RAM disk.


Richard B. Johnson
Project Engineer
Analogic Corporation
Penguin : Linux version 2.2.15 on an i586 machine (330.14 BogoMips).
