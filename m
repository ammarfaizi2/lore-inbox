Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSGQUqu>; Wed, 17 Jul 2002 16:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSGQUqt>; Wed, 17 Jul 2002 16:46:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:37384 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316768AbSGQUqE>; Wed, 17 Jul 2002 16:46:04 -0400
Date: Wed, 17 Jul 2002 17:39:54 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
In-Reply-To: <E17UvXF-0004Pu-00@starship>
Message-ID: <Pine.LNX.4.44L.0207171739070.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Daniel Phillips wrote:

> > > > Yes, I've always felt that at least one new list is needed to do the job
> > > > properly, and there are other considerations as well.
> > >
> > > > Obviously we don't want to be adding new lists and other experimental
> > > > cruft just now.

> Is the halloween freeze a code freeze?  I thought it was a feature freeze.

It is, but changing the way the VM works is also something that
should be done before a feature freeze. After the freeze we
really shouldn't "innovate" a lot and spend more time tweaking
whatever we have into perfection.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

