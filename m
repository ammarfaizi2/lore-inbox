Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVCEXaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVCEXaB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 18:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVCEX1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:27:21 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:55244 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261322AbVCEXDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:03:25 -0500
Date: Sat, 5 Mar 2005 18:03:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: domen@coderock.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, c.lucas@ifrance.com
Subject: Re: [patch 14/15] drivers/block/*: convert to pci_register_driver
Message-ID: <20050305230312.GA12887@havoc.gtf.org>
References: <20050305224327.781571F07A@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305224327.781571F07A@trashy.coderock.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 11:43:27PM +0100, domen@coderock.org wrote:
> 
> convert from pci_module_init to pci_register_driver
> 
> Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
> 
> 
>  kj-domen/drivers/block/DAC960.c |    2 +-
>  kj-domen/drivers/block/cciss.c  |    2 +-
>  kj-domen/drivers/block/sx8.c    |    2 +-
>  kj-domen/drivers/block/umem.c   |    2 +-


I ACK the sx8 portion.

Please CC me (the maintainer) on all sx8 patches.

	Jeff



