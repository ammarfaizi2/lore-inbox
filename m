Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbTCLPbd>; Wed, 12 Mar 2003 10:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbTCLPbd>; Wed, 12 Mar 2003 10:31:33 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:32568 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S261458AbTCLPbc>; Wed, 12 Mar 2003 10:31:32 -0500
Date: Wed, 12 Mar 2003 16:35:10 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <1047464392.1556.4.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.30.0303121629120.18304-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Mar 2003, Arjan van de Ven wrote:
> On Wed, 2003-03-12 at 07:07, Szakacsits Szabolcs wrote:
> > On 11 Mar 2003, Linus Torvalds wrote:
> > >
> > > If there is a well-known list of compilers, we should put a BIG warning
> > > in some core kernel file to guide people to upgrade (or maybe work
> >
> > Not enough, nobody would notice and today most end user doesn't
> > compile the kernel himself, they are just shipped by a broken kernels.
>
> and all vendors always ship -fno-frame-pointer kernels so far so those
> users are ok! Until recently there was no way to build a non
> -fno-frame-pointer kernel!

If all vendors is Red Hat then I believe you. I know Stephen C.
Tweedie audited the kernel. Please don't take things personally,
this is the kernel list.

	Szaka

