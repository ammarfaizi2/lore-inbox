Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312344AbSDUQFL>; Sun, 21 Apr 2002 12:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313480AbSDUQFK>; Sun, 21 Apr 2002 12:05:10 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:32173 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S312344AbSDUQFK>;
	Sun, 21 Apr 2002 12:05:10 -0400
Date: Sun, 21 Apr 2002 17:02:19 +0100
Message-Id: <200204211602.g3LG2JL29325@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <E16yx1z-0000jV-00@starship>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16yx1z-0000jV-00@starship> you wrote:

> It used to be that every major change would start with an [RFC].  Now the
> typical way is to build private concensus between a few well-placed
> individuals and go straight from there to feeding patches.  At least,
> that's my impression of the trend.

I disagree with you here. A short 2.5 list:

BIO - Jens posted patches for MONTHS to lkml (or changelogs with the patch
      on kernel.org); plenty of room for discussion 
O(1) scheduler - discussed quite a bit on lkml before Linus merged it
Preempt - discussed to the extreme before being merged
Ratcache - posted for months and discussed a lot on lkml
Andrew Morten's death-to-buffer - posted to lkml quite a bit, but of course
         it needs to work before it can be judged
VFS - you already said that you can see what's going on here

Now that leaves drivers and stuff. Well, for drivers, the maintainer
submitting updates, especially minor ones, directly to Linus
or the subsystem maintainer is fine by me. 


