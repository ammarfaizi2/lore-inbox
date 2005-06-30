Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVF3KTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVF3KTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVF3KRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:17:40 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:20748 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262925AbVF3KRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:17:20 -0400
To: arjan@infradead.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <1120125606.3181.32.camel@laptopd505.fenrus.org> (message from
	Arjan van de Ven on Thu, 30 Jun 2005 12:00:05 +0200)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <20050630022752.079155ef.akpm@osdl.org>
	 <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org>
Message-Id: <E1Dnw6N-0000V9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 Jun 2005 12:16:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if you are so interested in getting fuse merged... why not merge it
> first with the security stuff removed entirely. And then start
> discussing putting security stuff back in ?

BTW, I can split out the security stuff into a separate patch from the
rest, if people feel more confortable discussing a concrete patch,
instead of a range of lines (actually a 15 line function) of the
whole.

Miklos


