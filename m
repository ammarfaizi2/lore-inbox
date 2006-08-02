Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWHBVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWHBVqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWHBVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:46:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56291 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932238AbWHBVqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:46:02 -0400
Subject: Re: [PATCH] PCMCIA: Add few IDs into ide-cs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200608022310.03388.openembedded@hrw.one.pl>
References: <200608022310.03388.openembedded@hrw.one.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Aug 2006 23:04:56 +0100
Message-Id: <1154556296.23655.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-02 am 23:10 +0200, ysgrifennodd Marcin Juszkiewicz:
> From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
> 
> Few cards informations submitted by OpenZaurus users.
> 
> Seagate 8GB microdrive:
>  product info: "SEAGATE", "ST1"
>  manfid 0x0111, 0x0000
> 
> One CF card:
>  product info: "SAMSUNG", "04/05/06", "", ""
>  manfid : 0x0000, 0x0000
> 
> Ridata 8GB Pro 150X Compact Flash Card:
>  product info: "SMI VENDOR", "SMI PRODUCT", ""
>  manfid: 0x000a, 0x0000
> 
>  product info: "M-Systems", "CF500", ""
>  manfid: 0x000a, 0x0000
> 
> Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>

Acked-by: Alan Cox <alan@redhat.com>

(and I'll merge them into the libata pata_pcmcia driver too)


