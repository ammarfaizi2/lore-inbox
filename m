Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131524AbRCUPGb>; Wed, 21 Mar 2001 10:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbRCUPGV>; Wed, 21 Mar 2001 10:06:21 -0500
Received: from www.wen-online.de ([212.223.88.39]:14852 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131524AbRCUPGH>;
	Wed, 21 Mar 2001 10:06:07 -0500
Date: Wed, 21 Mar 2001 16:05:20 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Matthias Urlichs <smurf@noris.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <1eqmmju.3cit2gby1becM%smurf@noris.de>
Message-ID: <Pine.LNX.4.33.0103211601400.1565-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Matthias Urlichs wrote:

> > > I frequently build Mozilla from scratch on my (aging) dual Celeron
> > > machine.  [...]
> > >     real    60m4.574s
> > >     user    101m18.260s  <-- impossible no?
> > >     sys     3m23.520s
> >
> > Why do numbers like this show up?  I noticed some of this after having
> > enabled SMP on my UP box.
> >
> Now why would that be impossible on a two-CPU system?

zzzt.  Right.. impossible on a UP box.

	-Mike

