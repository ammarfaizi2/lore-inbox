Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284650AbRLEUKS>; Wed, 5 Dec 2001 15:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284652AbRLEUJL>; Wed, 5 Dec 2001 15:09:11 -0500
Received: from mustard.heime.net ([194.234.65.222]:31894 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284653AbRLEUIC>; Wed, 5 Dec 2001 15:08:02 -0500
Date: Wed, 5 Dec 2001 21:07:42 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Pablo Borges <pablo.borges@uol.com.br>
cc: Helge Hafting <helgehaf@idb.hist.no>, <war@starband.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <20011205175741.124caeff.pablo.borges@uol.com.br>
Message-ID: <Pine.LNX.4.30.0112052106450.3740-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Absolutely all free memory may be used for disk caching.  So
> > no, you can't get a bigger cache because it is already at
> > the highest possible setting.  You don't have more memory
> > for this - all is used already.
>
> May I limit this memory ? For a long time I'm working all day with no physical memory available.

You can try rtlinux. In rtlinux (realtime linux), you tell linux how much
memory the kernel will have access to, and let specially written apps to
take the rest
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

