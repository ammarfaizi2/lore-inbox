Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289631AbSA2OoW>; Tue, 29 Jan 2002 09:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289643AbSA2OoH>; Tue, 29 Jan 2002 09:44:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9686 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289631AbSA2Onq>;
	Tue, 29 Jan 2002 09:43:46 -0500
Date: Tue, 29 Jan 2002 17:41:22 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <E16VZex-00047c-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201291740220.12485-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Alan Cox wrote:

> A correct patch for this one giving a new maintainer was posted to
> Linux kernel already

ok.

> >  DRM DRIVERS
> >  P:	Rik Faith
> > -M:	faith@valinux.com
> >  L:	dri-devel@lists.sourceforge.net
> >  S:	Supported
>
> Rik moved from VA so I suspect you want to look in the RH internal directory
> for the correct one there 8)

*blush* :-) The correct patch is:

-M:	faith@valinux.com
+M:	faith@redhat.com

	Ingo

