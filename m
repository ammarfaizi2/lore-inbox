Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUAZVBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUAZVBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:01:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21995 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265148AbUAZVBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:01:34 -0500
Date: Mon, 26 Jan 2004 22:01:26 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: jt@hpl.hp.com
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] fix via-ircc.c .text.exit error
Message-ID: <20040126210126.GG513@fs.tum.de>
References: <Pine.LNX.4.58L.0401161207000.28357@logos.cnet> <20040125004030.GE6441@fs.tum.de> <20040126192836.GA17134@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126192836.GA17134@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 11:28:36AM -0800, Jean Tourrilhes wrote:
>
> 	Thanks you Adrian. Yes, I must confess that I never test
> non-modular build (because it doesn't work).
>...

Are you saying it might compile statically, but it won't work?

In this case, what about disallowing building it statically in the 
Config.in?

> 	Jean
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

