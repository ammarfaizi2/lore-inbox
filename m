Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313118AbSELNHh>; Sun, 12 May 2002 09:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSELNHg>; Sun, 12 May 2002 09:07:36 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:24071 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313118AbSELNHg>; Sun, 12 May 2002 09:07:36 -0400
Date: Sun, 12 May 2002 15:07:32 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Pawel Kot <pkot@linuxnews.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac2
Message-ID: <20020512130732.GG3749@louise.pinerecords.com>
In-Reply-To: <20020512125151.GD3749@louise.pinerecords.com> <Pine.LNX.4.33.0205121501190.493-100000@urtica.linuxnews.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 1 day, 4:41)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Pawel Kot <pkot@linuxnews.pl>, May-12 2002, Sun, 15:04 +0200]
> 
> > > [Alan Cox <alan@redhat.com>, May-11 2002, Sat, 19:47 -0400]
> > >
> > > Linux 2.4.19pre8-ac2
> >
> > Alan, do you suppose you could integrate the new backported NTFS code in
> > -ac at some not-so-distant point in time? I reckon that would be a generally
> > appreciated decision, as demand of decent NTFS access has existed for
> > quite a bit of time already and 2.6 will yet take a while to land.
> 
> Current version (2.0.7a) of the backported NTFS will not work with -ac
> kernels with preemption enabled. I just finished adding preemption patch
> for it and hopefully after (successful) tests will release 2.0.7b.

AFAIK preempt-kernel has not been merged with -ac, it's only available as
an add-on patch.


T.
