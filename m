Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268658AbUIXKGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268658AbUIXKGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268660AbUIXKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:06:06 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:42923 "EHLO
	holub.nextsoft.cz") by vger.kernel.org with ESMTP id S268658AbUIXKGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:06:03 -0400
From: Michal Rokos <michal@rokos.info>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.9-rc2-mm3
Date: Fri, 24 Sep 2004 12:05:31 +0200
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040924014643.484470b1.akpm@osdl.org> <4153EED2.1050508@yahoo.com.au>
In-Reply-To: <4153EED2.1050508@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241205.31735.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 24 of September 2004 11:54, Nick Piggin wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9
> >-rc2/2.6.9-rc2-mm3/
> >
> >
> > +natsemi-remove-compilation-warnings.patch
> >
> >  natsemi.c warning fixes
>
> My card fails to work unless this change is backed out.

Yeah - very true.

I didn't have time to find out why... The change looked very innocent.

Michal

PS: I warned about it yesterday.
http://marc.theaimsgroup.com/?l=linux-kernel&m=109594207116846&w=4

