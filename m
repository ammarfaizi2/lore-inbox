Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264737AbSJUE6a>; Mon, 21 Oct 2002 00:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264738AbSJUE63>; Mon, 21 Oct 2002 00:58:29 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:22922 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S264737AbSJUE63>;
	Mon, 21 Oct 2002 00:58:29 -0400
Message-ID: <1035176673.3db38ae1dc9e4@kolivas.net>
Date: Mon, 21 Oct 2002 15:04:33 +1000
From: Con Kolivas <conman@kolivas.net>
To: landley@trommello.org
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ck performance patchset for 2.4.19 broken out as ck10
References: <200210200005.08444.conman@kolivas.net> <200210201857.28851.landley@trommello.org>
In-Reply-To: <200210201857.28851.landley@trommello.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Landley <landley@trommello.org>:

> On Saturday 19 October 2002 09:05, Con Kolivas wrote:
> > Hi
> >
> > My merged performance patchset (-ck) containing
> >
> > O(1) + batch scheduling
> > Preemptible
> > Low Latency
> > Compressed Caching or
> > AA VM addons
> > XFS
> > ALSA
> > Supermount
> 
> I don't see compressed caching on the 2.5 status list.  I take it this patch

Correct. R.S.de Castro is the maintainter and has never pushed for it to be
included in any mainstream kernel.

Con
