Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTHJLuz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTHJLuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:50:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50417 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262385AbTHJLuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:50:54 -0400
Date: Sun, 10 Aug 2003 13:50:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 can't compile
Message-ID: <20030810115047.GW16091@fs.tum.de>
References: <200308101307.13600.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308101307.13600.cijoml@volny.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 01:07:13PM +0200, Michal Semler wrote:

> Hi,

Hi Michal,

> I tried compile 2.6.0-test3, but I got this error messages:
> gcc-3.3, Debian Woody with bunk debs
> 
> arch/i386/kernel/built-in.o(.data+0x14d4): In function `do_suspend_lowlevel':
> : undefined reference to `save_processor_state'
>...

please send your .config.

> Michal

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

