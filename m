Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268192AbUBRVoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268199AbUBRVoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:44:09 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:50189 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268192AbUBRVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:44:04 -0500
Date: Wed, 18 Feb 2004 21:43:57 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: rihad <rihad@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: rivafb woes
In-Reply-To: <4033BE48.1080900@mail.ru>
Message-ID: <Pine.LNX.4.44.0402182143420.10389-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Th emost recent cards are not supported. Its being worked on.


On Wed, 18 Feb 2004, rihad wrote:

> I can't get rivafb to work on my GF-MX440! Am I wrong in thinking that
> CONFIG_FB_RIVA is a drop-in faster replacement for CONFIG_FB_VESA? Or do
> I need both of them compiled in? All I get when trying to boot is a
> blank or a messed up screen. The penguin is there though :) Here's the
> relevant lines of my lilo.conf:
> 
> vga=0x317
> image=/boot/vmlinuz-2.6.3
>        append="video=rivafb:1024x768-16@60"
> 
> $ lspci
> [snip]
> 01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX
> 440] (rev a3)
> 
> TIA!
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

