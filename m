Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268858AbUHaUAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268858AbUHaUAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269064AbUHaUAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:00:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3577 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268965AbUHaUAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:00:04 -0400
Date: Tue, 31 Aug 2004 21:59:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2: why is DIGIEPCA marked BROKEN?
Message-ID: <20040831195951.GO3466@fs.tum.de>
References: <20040830235426.441f5b51.akpm@osdl.org> <20040831174719.GG3466@fs.tum.de> <20040831195753.GA12499@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831195753.GA12499@lst.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 09:57:53PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 31, 2004 at 07:47:19PM +0200, Adrian Bunk wrote:
> > If I revert mark-pcxx-as-broken.patch, the driver compiles UP for me 
> > with exactly zero errors or warnings.
> > 
> > @Christoph:
> > Could you post the errors you observed?
> 
> Umm, sorry.   As the patch name says it should have marked the pcxx
> driver (CONFIG_DIGI) as broken.
>...

Too late, my patch to fix the compile errors in DIGI was already sent.
;-)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

