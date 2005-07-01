Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263235AbVGAGXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbVGAGXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 02:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbVGAGXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 02:23:52 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:60935 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263235AbVGAGXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 02:23:50 -0400
To: avuton@gmail.com
CC: arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <3aa654a4050630123937e1fcba@mail.gmail.com> (message from Avuton
	Olrich on Thu, 30 Jun 2005 12:39:37 -0700)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <20050630022752.079155ef.akpm@osdl.org>
	 <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	 <1120125606.3181.32.camel@laptopd505.fenrus.org>
	 <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	 <1120126804.3181.34.camel@laptopd505.fenrus.org>
	 <E1DnwDI-0000WT-00@dorka.pomaz.szeredi.hu> <3aa654a4050630123937e1fcba@mail.gmail.com>
Message-Id: <E1DoEvj-0002KC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 08:23:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Then can you please accept that FUSE will not get merged right now.
> > My argument is: IF it's not going to get merged now, can we please
> > continue the discussion about why it's unacceptable, and what are the
> > alternatives.
> 
> Why has there not been more discussion about just making an option for
> those 15 lines, just for merging's sake, and hopefully after more
> discussion, the option will go away one way or another. On the other
> hand everyone says security, security, security and I don't remember
> one person actually saying something negative about what it does to
> security.

There is a mount option: 'allow_other' which does just this.  Or did
you mean a config option?

Thanks,
Miklos
