Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267934AbRGWWFu>; Mon, 23 Jul 2001 18:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267933AbRGWWFa>; Mon, 23 Jul 2001 18:05:30 -0400
Received: from anime.net ([63.172.78.150]:34566 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S267934AbRGWWFU>;
	Mon, 23 Jul 2001 18:05:20 -0400
Date: Mon, 23 Jul 2001 15:05:03 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <laughing@shared-source.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Athlon/MSI mobo combo broken?
In-Reply-To: <20010723183204.B27310@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0107231503240.13434-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001, Alan Cox wrote:
> On Mon, Jul 23, 2001 at 06:02:01PM +0200, Felix von Leitner wrote:
> > When I compile the same kernel for Pentium Pro, it works.  How can this
> > be?
> Theory right now: Because the Athlon kernel does streaming memory copies at
> full bus performance. Not all VIA chipset boards seem to cope.

I fixed my MSI/athlon stability problems by reducing PS load. My next
purchase will be a 450W PS to replace my 300W.

Athlons are real power suckers, 300W is probably 'barely enough' for
typical PC.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

