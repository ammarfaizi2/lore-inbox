Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292582AbSCABTI>; Thu, 28 Feb 2002 20:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310159AbSCABRb>; Thu, 28 Feb 2002 20:17:31 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:23057 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310291AbSCABOt>;
	Thu, 28 Feb 2002 20:14:49 -0500
Date: Thu, 28 Feb 2002 22:14:31 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Christoph Hellwig <hch@caldera.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the
In-Reply-To: <E16gbTG-0001rM-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0202282214230.2801-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Alan Cox wrote:

> > or (c) have proponents of the inclusion of the O(1) scheduler
> > fix all drivers before having the O(1) scheduler considered
> > for inclusion.
>
> According to find and grep the patch in general use does precisely that
> except for Andrea's yield loops on init kill funnies that still lurk in
> the non x86 parts of rmap. If rmap doesnt need them I guess they should go ?

Absolutely.

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

