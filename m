Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290732AbSAYRED>; Fri, 25 Jan 2002 12:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290733AbSAYRDx>; Fri, 25 Jan 2002 12:03:53 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1811 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290732AbSAYRDn>;
	Fri, 25 Jan 2002 12:03:43 -0500
Date: Fri, 25 Jan 2002 15:03:16 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: David Weinehall <tao@acc.umu.se>
Cc: <rwhron@earthlink.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18pre4aa1
In-Reply-To: <20020125061801.W1735@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.33L.0201251502230.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, David Weinehall wrote:

> One thing that struck me about this; doesn't both the rmap-patches and
> the aa-patches contain other changes than merely changes to the VM? If
> so, couldn't these changes tip the result in an unfair direction?! After
> all, what we want is a VM-to-VM shoot-out, not a VM-to-VM+whatever
> shoot-out. After all, one would assume that the non VM-related changes
> would be merged to the kernel no matter what VM is used, right?

The -aa kernel seems to contain patches to a few dozen subsystems.

The -rmap patch is pretty much only VM changes.

You're right that this is not a strict VM vs VM comparison...

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

