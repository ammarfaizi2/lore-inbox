Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315514AbSECA54>; Thu, 2 May 2002 20:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315515AbSECA5z>; Thu, 2 May 2002 20:57:55 -0400
Received: from conn6m.toms.net ([64.32.246.219]:34476 "EHLO conn6m.toms.net")
	by vger.kernel.org with ESMTP id <S315514AbSECA5y>;
	Thu, 2 May 2002 20:57:54 -0400
Date: Thu, 2 May 2002 20:57:40 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: module choices affecting base kernel size??? 
In-Reply-To: <1427.1020383901@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0205022054160.8024-100000@conn6m.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Tom Oehser <tom@toms.net> wrote:
> >Changing all =m to =n in my config makes a 4K difference in the kernel size.

On Fri, 3 May 2002, Keith Owens wrote:

> The majority of modules have no effect on kernel size but some modules
> require base kernel code as well.  This is typically common code or low
> level setup functions.  You will find that those modules will not load
> now or will break.

Great.  I must have missed the list of exactly *which* modules do this...

Any ideas on a reasonable way of how to identify them?

-Tom

