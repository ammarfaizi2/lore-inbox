Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSDXJDQ>; Wed, 24 Apr 2002 05:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSDXJDP>; Wed, 24 Apr 2002 05:03:15 -0400
Received: from Expansa.sns.it ([192.167.206.189]:18703 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S293510AbSDXJDD>;
	Wed, 24 Apr 2002 05:03:03 -0400
Date: Wed, 24 Apr 2002 11:02:58 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: m.knoblauch@TeraPort.de
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
In-Reply-To: <3CC65B35.686100AF@TeraPort.de>
Message-ID: <Pine.LNX.4.44.0204241054280.24376-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Apr 2002, Martin Knoblauch wrote:

> Luigi Genoni wrote:
> >
> > On Tue, 23 Apr 2002, Martin Knoblauch wrote:
> >
> > > > Re: XFS in the main kernel
> > > >
> > >  definitely. Unless XFS is in the mainline kernel (marked as
> > > experimantal if necessary) it will not get good exposure.
> >
> > XFS needs 2.5, not 2.4, because of a lot of reasons.
> > If I do remember well a strong obiection to XFS is that it introduces a
> > kernel thread to emulate Irix behavious to talk with pagebuf (a la Irix),
> > end to have an interface with VM and Block Device layer.
> >
> > This forces some vincles.
> >
>
>  No problem with XFS going into 2.5 mainline, but not 2.4. But - is that
> happening?
>
I do not think so. At the end it is Linus the one who should decide, and
XFS should find a way to agree with him. All depends on this.



