Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129615AbQKBKde>; Thu, 2 Nov 2000 05:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129981AbQKBKdY>; Thu, 2 Nov 2000 05:33:24 -0500
Received: from ocmax5-087.dialup.optusnet.com.au ([198.142.38.87]:8207 "HELO
	tae-bo.generica.dyndns.org") by vger.kernel.org with SMTP
	id <S129626AbQKBKdW>; Thu, 2 Nov 2000 05:33:22 -0500
Date: Thu, 2 Nov 2000 21:38:33 +1100 (EST)
From: Brett <bpemberton@dingoblue.net.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Narancs 1 <narancs1@externet.hu>, kraxel@goldbach.in-berlin.de,
        linux-kernel@vger.kernel.org
Subject: Re: vesafb doesn't work in 240t10?
In-Reply-To: <3A01408D.6DBE85F9@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011022137270.16072-100000@tae-bo.generica.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Jeff Garzik wrote:

> Narancs 1 wrote:
> > I used to start vesafb like this:
> > /etc/lilo.conf:
> > vga=317
> 
> So, use "vga=791" in your lilo.conf.
> 
> 

Interesting...

I have 

	vga=0x31a

in /etc/lilo.conf,
and it works fine

$ lilo -V
LILO version 21.6

*shrug*

	/ Brett

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
