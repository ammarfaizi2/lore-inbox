Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRKSOXW>; Mon, 19 Nov 2001 09:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279261AbRKSOXL>; Mon, 19 Nov 2001 09:23:11 -0500
Received: from mustard.heime.net ([194.234.65.222]:48587 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S279084AbRKSOXG>; Mon, 19 Nov 2001 09:23:06 -0500
Date: Mon, 19 Nov 2001 15:22:55 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Remco Post <r.post@sara.nl>
cc: James A Sutherland <jas88@cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: swap? 
In-Reply-To: <200111191357.OAA04801@zhadum.sara.nl>
Message-ID: <Pine.LNX.4.30.0111191501560.3669-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > What about a tux-only system?
> > > should I disable swap?
>
> On a tux only system, you'll have very little data that is not on a
> filesystem. Since all other applications running (you'll wind up with at least
> 20 or so processes like syslogd...) are very small, and those will use very
> little data-pages, you'll probably see no benefit from having a swappartition.
> Having enough RAM to be used as a buffer-cache seems more usefull. Unused
> code-pages of userland apps will be discarded anyway. Leaving you with more
> memory to be used as a buffer-cache.

What could be the overhead of using swap?
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


