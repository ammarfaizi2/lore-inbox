Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWAIPaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWAIPaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWAIPaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:30:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:40081 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932295AbWAIP37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:29:59 -0500
Date: Mon, 9 Jan 2006 11:06:55 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "G.W. Haywood" <ged@jubileegroup.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ne2k PCI/ISA documentation: improved cross-reference.
Message-ID: <20060109130655.GA4687@dmt.cnet>
References: <Pine.LNX.4.58.0512291301420.2118@mail3.jubileegroup.co.uk> <9a8748490512290553g448d1e28w65dad834cd08e1a7@mail.gmail.com> <Pine.LNX.4.58.0512291520250.6219@mail3.jubileegroup.co.uk> <200512292149.55237.jesper.juhl@gmail.com> <Pine.LNX.4.58.0601071459440.8957@mail3.jubileegroup.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601071459440.8957@mail3.jubileegroup.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 03:11:40PM +0000, G.W. Haywood wrote:
> From: Ged Haywood <ged@jubileegroup.co.uk>
> 
> Improved reference to PCI ne2k support in ISA ne2k documentation.
> 
> Signed-off-by: Ged Haywood <ged@jubileegroup.co.uk>
> ---
>  Configure.help |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> --- linux-2.4.32/Documentation/Configure.help.original  2006-01-07 14:48:23.000000000 +0000
> +++ linux-2.4.32/Documentation/Configure.help   2006-01-07 14:56:32.000000000 +0000
> @@ -12778,7 +12778,8 @@
>    without a specific driver are compatible with NE2000.
> 
>    If you have a PCI NE2000 card however, say N here and Y to "PCI
> -  NE2000 support", above. If you have a NE2000 card and are running on
> +  NE2000 and clones support" under "EISA, VLB, PCI and on board
> +  controllers" below.  If you have a NE2000 card and are running on
>    an MCA system (a bus system used on some IBM PS/2 computers and
>    laptops), say N here and Y to "NE/2 (ne2000 MCA version) support",
>    below.

Hi Ged,

Appreciate your efforts but the v2.4 tree is under deep maintenance mode
with an acceptance criteria for critical bugfixes only.

