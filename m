Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263177AbUDVEIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbUDVEIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 00:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbUDVEIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 00:08:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:2725 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263177AbUDVEIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 00:08:15 -0400
Date: Wed, 21 Apr 2004 21:07:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, mpm@selenic.com,
       zwane@linuxpower.ca
Subject: Re: [PATCH] Kconfig.debug family
Message-Id: <20040421210754.49318f0d.akpm@osdl.org>
In-Reply-To: <20040421205140.445ae864.rddunlap@osdl.org>
References: <20040421205140.445ae864.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Localizes kernel debug options in lib/Kconfig.debug.
>  Puts arch-specific debug options in $ARCH/Kconfig.debug.
> 
>  updated for 2.6.6-rc2
> 
>  http://developer.osdl.org/rddunlap/patches/kconf_debug_1file_266rc2.patch
> 
>  Also included here as a gzipped attachment.
> 
> ...
>   42 files changed, 1084 insertions(+), 1717 deletions(-)
> 
> 
>  Like it, kill/drop it, fix (what?) problems, ... ?

It breaks at least six patches from -mm and I'm too lazy to do anything
about it.

Please resend after 2.6.6.

