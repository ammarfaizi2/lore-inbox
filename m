Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131485AbRCUO6B>; Wed, 21 Mar 2001 09:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131489AbRCUO5v>; Wed, 21 Mar 2001 09:57:51 -0500
Received: from paperboy.noris.net ([62.128.1.27]:27525 "EHLO mail2.noris.net")
	by vger.kernel.org with ESMTP id <S131485AbRCUO5n>;
	Wed, 21 Mar 2001 09:57:43 -0500
To: mikeg@wen-online.de (Mike Galbraith), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0103210733470.929-100000@mikeg.weiden.de>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
From: smurf@noris.de (Matthias Urlichs)
Date: Wed, 21 Mar 2001 15:56:54 +0100
Message-ID: <1eqmmju.3cit2gby1becM%smurf@noris.de>
Organization: noris network AG
User-Agent: MacSOUP/2.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I frequently build Mozilla from scratch on my (aging) dual Celeron
> > machine.  [...]
> >     real    60m4.574s
> >     user    101m18.260s  <-- impossible no?
> >     sys     3m23.520s
> 
> Why do numbers like this show up?  I noticed some of this after having
> enabled SMP on my UP box.
> 
Now why would that be impossible on a two-CPU system?
