Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265311AbUFTSct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUFTSct (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 14:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUFTSct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 14:32:49 -0400
Received: from havoc.gtf.org ([216.162.42.101]:53198 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263750AbUFTScr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 14:32:47 -0400
Date: Sun, 20 Jun 2004 14:32:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 155] Mac Sonic Ethernet
Message-ID: <20040620183234.GA26036@havoc.gtf.org>
References: <200406201720.i5KHKpne001344@anakin.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406201720.i5KHKpne001344@anakin.of.borg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 07:20:51PM +0200, Geert Uytterhoeven wrote:
> Mac Sonic Ethernet updates (from Matthias Urlichs in 2.6):
>   - Fix memory leak in error path
>   - Kill obsolete namespace stuff
>   - Kill duplicate `MODULE_LICENSE("GPL");' (already defined in included
>     sonic.c) which causes a compile failure
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

ACK
