Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUHCRiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUHCRiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUHCRiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:38:15 -0400
Received: from [138.15.108.3] ([138.15.108.3]:14559 "EHLO mailer.nec-labs.com")
	by vger.kernel.org with ESMTP id S266766AbUHCRiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:38:04 -0400
Subject: Re: Problem installing cloop
From: Lei Yang <leiyang@nec-labs.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>
In-Reply-To: <20040803171433.GC925@lorien.prodam>
References: <1091563549.5487.62.camel@bijar.nec-labs.com>
	 <20040803171433.GC925@lorien.prodam>
Content-Type: text/plain
Message-Id: <1091565476.5487.64.camel@bijar.nec-labs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 13:37:56 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Aug 2004 17:37:54.0624 (UTC) FILETIME=[9B953C00:01C47980]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!!
But would the patch work with kernel 2.6.5?

Lei

On Tue, 2004-08-03 at 10:14, Luiz Fernando N. Capitulino wrote:
>  Hi Lei,
> 
> Em Tue, Aug 03, 2004 at 01:05:50PM -0700, Lei Yang escreveu:
> 
> | I was trying to get
> | cloop-2.0.1 built and installed on a SuSe 9.1 box with kernel version
> | 2.6.5 . I followed all the instructions in    
> | http://www.knopper.net/download/knoppix/cloop.README
> 
>  Well, I did a cleanup in the cloop code, merged it in 2.6.7, and
> enabled it in Kconfig:
> 
>  The patch is here:
> 
> http://www.telecentros.sp.gov.br/capitulino/patches/linux/2.6/cloop/2.6.7/
> 
>  I did it for another project some weeks ago, sorry for not posting
> it here before (But, as far as I can remember, I sent it to knopper).
> 
> PS: Its a patch again't the kernel, you will have to get the standard
> tools from knopper page.
> 
>  Hope it helps,

