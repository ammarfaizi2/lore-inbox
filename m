Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUGJQmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUGJQmj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 12:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUGJQmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 12:42:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:485 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266292AbUGJQmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 12:42:37 -0400
Date: Sat, 10 Jul 2004 13:03:43 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "IIDA, MASANARI" <masanari.iida@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A typo in sysrq.c on 2.4.26
Message-ID: <20040710160342.GA15441@logos.cnet>
References: <C55A99FE1AE9704D9C3F5632AC09BC1AA3B325@tkoexc09.asiapacific.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C55A99FE1AE9704D9C3F5632AC09BC1AA3B325@tkoexc09.asiapacific.cpqcorp.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 08:13:21PM +0900, IIDA, MASANARI wrote:
> Hi Marcelo
> 
> This patch fix a typo in drivers/char/sysrq.c on 2.4.26.
> I have confirmed kernel 2.6.7 doesn't have this typo.
> 
> --- drivers/char/sysrq.c        Mon Aug 25 20:44:41 2003
> +++ drivers/char/sysrq.c.new    Fri Jul  9 19:58:07 2004
> @@ -365,7 +365,7 @@
>  /* v */        NULL,
>  /* w */        NULL,
>  /* x */        NULL,
> -/* w */        NULL,
> +/* y */        NULL,
>  /* z */        NULL
>  };

Hi,

Patch applied, thanks.
