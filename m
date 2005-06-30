Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVF3KN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVF3KN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVF3KN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:13:29 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:49424 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262926AbVF3KNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:13:18 -0400
To: arjan@infradead.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <1120125606.3181.32.camel@laptopd505.fenrus.org> (message from
	Arjan van de Ven on Thu, 30 Jun 2005 12:00:05 +0200)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <20050630022752.079155ef.akpm@osdl.org>
	 <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org>
Message-Id: <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 Jun 2005 12:12:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if you are so interested in getting fuse merged... why not merge it
> first with the security stuff removed entirely. And then start
> discussing putting security stuff back in ?

  a) it's already been discussed to death (just search for 'fuse' on
     lkml and fsdevel)

  b) I don't consider it a good idea to ship a defunct version of it in
     the mainline

Can you please accept my wish to have FUSE merged _with_ the
unprivileged mount's thing.

If anybody has anything to add to the discussion, please do it now,
and not later.  Delaying this further won't get us any bonus IMO.

Miklos
