Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129722AbQKBOPp>; Thu, 2 Nov 2000 09:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131845AbQKBOPf>; Thu, 2 Nov 2000 09:15:35 -0500
Received: from Prins.externet.hu ([212.40.96.161]:46612 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S129722AbQKBOPY>; Thu, 2 Nov 2000 09:15:24 -0500
Date: Thu, 2 Nov 2000 15:15:08 +0100 (CET)
From: Narancs 1 <narancs1@externet.hu>
To: Brett <bpemberton@dingoblue.net.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, kraxel@goldbach.in-berlin.de,
        linux-kernel@vger.kernel.org
Subject: Re: vesafb doesn't work in 240t10?
In-Reply-To: <Pine.LNX.4.21.0011022137270.16072-100000@tae-bo.generica.dyndns.org>
Message-ID: <Pine.LNX.4.02.10011021512560.5828-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Brett wrote:

> On Thu, 2 Nov 2000, Jeff Garzik wrote:

> 	vga=0x317
> 
> in /etc/lilo.conf,

works fine on the other machine, containing a savage4 agp card

It seems that the i815 is not vesa compliant?
Cheap!

What fb driver would support it?
does vga16 support 1024x768?

thx4all 

Narancs v1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
