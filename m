Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317416AbSFXGn2>; Mon, 24 Jun 2002 02:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSFXGn1>; Mon, 24 Jun 2002 02:43:27 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:8412 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S317416AbSFXGn1>;
	Mon, 24 Jun 2002 02:43:27 -0400
Date: Mon, 24 Jun 2002 08:43:25 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : drivers/net/tlan.c
Message-ID: <20020624084325.B22534@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain>; from fdavis@si.rr.com on Sun, Jun 23, 2002 at 10:34:37PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re,

Frank Davis <fdavis@si.rr.com> :
> Hello all,
>   This patch adds the check for 32-bit DMA capability for the tlan driver. 
> This is the first step for Documentation/DMA-mapping.txt compliance. As 
> for the preferred action if the driver fails on pci_set_dma_mask(), I plan 
> to add that in a future patch. Please review. 

See comment regarding scsi drivers.

I've done some work for this one and rrunner around 2.4.7. Give me 24h to
dig the mail archive and see what the missing parts/problems were, ok ?

Btw, you may Cc:jgarzik@mandrakesoft.com as well as the adequate maintainer
if there's one.

-- 
Ueimor
