Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWJPNUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWJPNUO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWJPNUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:20:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20362 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750816AbWJPNUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:20:13 -0400
Subject: Re: [PATCH] sx: fix user-visible typo (devic)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061016120156.GA5483@martell.zuzino.mipt.ru>
References: <20061016120156.GA5483@martell.zuzino.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 14:46:52 +0100
Message-Id: <1161006413.24237.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 16:01 +0400, ysgrifennodd Alexey Dobriyan:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/char/sx.c               |    2 +-
>  drivers/mtd/chips/jedec_probe.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)


Acked-by: Alan Cox <alan@redhat.com>

