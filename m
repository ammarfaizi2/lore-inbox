Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275408AbTHIUlB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275409AbTHIUlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:41:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61636 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275408AbTHIUk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:40:59 -0400
Date: Sat, 9 Aug 2003 22:40:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Adam Belay <ambx1@neo.rr.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030809204051.GQ16091@fs.tum.de>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622234447.GB3710@fs.tum.de> <20030623000808.GA14945@neo.rr.com> <20030703025343.GC282@fs.tum.de> <20030703190304.GA17707@neo.rr.com> <20030704121124.GB12633@fs.tum.de> <20030715224732.GA31942@neo.rr.com> <20030716182251.GW10191@fs.tum.de> <20030716184317.GC31942@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716184317.GC31942@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 06:43:17PM +0000, Adam Belay wrote:
>...
> Hi Adrian,

Hi Adam,

>...
> Also there is a kernel parameter to allow dma 0.  It is 'allowdma0' and
> I predict the extra dma will get the sound card working.

FYI:
I do still need allowdma0 for working sound in 2.6.0-test3.

> Thanks,
> Adam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

