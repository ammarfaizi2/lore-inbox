Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313128AbSELNOI>; Sun, 12 May 2002 09:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313161AbSELNOH>; Sun, 12 May 2002 09:14:07 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:27908 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S313128AbSELNOF>; Sun, 12 May 2002 09:14:05 -0400
Date: Sun, 12 May 2002 15:14:03 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Tomas Szepe <szepe@pinerecords.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19pre8-ac2
In-Reply-To: <20020512130732.GG3749@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.33.0205121513110.493-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Tomas Szepe wrote:

> > [Pawel Kot <pkot@linuxnews.pl>, May-12 2002, Sun, 15:04 +0200]
> >
> > > > [Alan Cox <alan@redhat.com>, May-11 2002, Sat, 19:47 -0400]
> > > >
> > > > Linux 2.4.19pre8-ac2
> > >
> > > Alan, do you suppose you could integrate the new backported NTFS code in
> > > -ac at some not-so-distant point in time? I reckon that would be a generally
> > > appreciated decision, as demand of decent NTFS access has existed for
> > > quite a bit of time already and 2.6 will yet take a while to land.
> >
> > Current version (2.0.7a) of the backported NTFS will not work with -ac
> > kernels with preemption enabled. I just finished adding preemption patch
> > for it and hopefully after (successful) tests will release 2.0.7b.
>
> AFAIK preempt-kernel has not been merged with -ac, it's only available as
> an add-on patch.

Ouch, sorry then, I thought it's in the -ac already. Anyway other
statements from my email are still valid :-)

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

