Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTF0Nsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 09:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTF0Nsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 09:48:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33774 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264289AbTF0Nso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 09:48:44 -0400
Date: Fri, 27 Jun 2003 16:02:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill extra printk prototype
Message-ID: <20030627140252.GF24661@fs.tum.de>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva> <20030626233117.GO3827@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626233117.GO3827@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 01:31:17AM +0200, J.A. Magallon wrote:
> 
> On 06.27, Marcelo Tosatti wrote:
> > 
> > Hello,
> > 
> > Here goes -pre2 with a big number of changes, including the new aic7xxx
> > driver.
> > 
> > I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> > short.
> > 
> 
> Alredy declared in kernel.h.
>...

It seems this issue is also present in 2.5.73.

Could you send such cleanup changes for inclusion into 2.5 first?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

