Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132755AbRDNFuN>; Sat, 14 Apr 2001 01:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132743AbRDNFuE>; Sat, 14 Apr 2001 01:50:04 -0400
Received: from zeus.kernel.org ([209.10.41.242]:32728 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132763AbRDNFt6>;
	Sat, 14 Apr 2001 01:49:58 -0400
Date: Sat, 14 Apr 2001 00:33:34 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <esr@thyrsus.com>, <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: CML2 1.0.0 doesn't remember configuration changes
In-Reply-To: <3AD7B619.D1A812CC@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104140032150.24402-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Apr 2001, Jeff Garzik wrote:

> "Eric S. Raymond" wrote:
> > OK, 1.1.0 will do these things.  I'm still not certain I have `make
> > oldconfig' right, but I trust someone will club me gently over the
> > head if it's still not up to spec.
>
> Yep :)   'vi .config' + 'make oldconfig' is the most efficient way to
> update your kernel config, if you really know what you are doing.

I thought I was the only one to do that!  =-)


Nicolas

