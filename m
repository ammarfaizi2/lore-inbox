Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317998AbSFSU0H>; Wed, 19 Jun 2002 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318000AbSFSU0G>; Wed, 19 Jun 2002 16:26:06 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:25352 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317998AbSFSU0F>; Wed, 19 Jun 2002 16:26:05 -0400
Date: Wed, 19 Jun 2002 13:25:27 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [PATCH] (2/2) reverse mappings for current 2.5.23 VM
In-Reply-To: <E17KjXH-0000vN-00@starship>
Message-ID: <Pine.LNX.4.44.0206191322110.4292-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Daniel Phillips wrote:

> On Wednesday 19 June 2002 13:21, Craig Kulesa wrote:
> > 2.5.22 vanilla:
>       ^^--- is this a typo?

Good eye, but no.  I was indeed comparing 2.5.22 to the 2.5.23 rmap 
patches.  I performed the same test on 2.5.23 later and its behavior is 
similar. 

-Craig

