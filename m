Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUGJMFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUGJMFR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUGJMFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:05:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59336 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266221AbUGJMFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:05:06 -0400
Date: Sat, 10 Jul 2004 14:05:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Manjunath <manjunath.n@ap.sony.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Regarding Kernel 2.6.5
Message-ID: <20040710120500.GJ28324@fs.tum.de>
References: <1089087274.5155.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089087274.5155.35.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 09:44:34AM +0530, Manjunath wrote:

> hi,

Hi Manju,

> I tried to build Kernel 2.6.5 on Fedora Core 1.
> make modules_install gives me this error
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.6.5-gcov/kernel/net/irda/irnet/irnet.ko
> depmod:         irttp_open_tsap
> depmod:         iriap_getvaluebyclass_request
> depmod:         irda_notify_init
> make: *** [_modinst_post] Error 1
> 
> On Fedora Core 1.

if you are able to reproduce this with an unmodified ftp.kernel.org 
kernel (preferzble 2.6.7) please send your .config .

If not, please report this issue to RedHat.

> Regards
> Manju

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

