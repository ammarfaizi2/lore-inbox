Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270133AbTGNQPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270257AbTGNQPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:15:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42190 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270133AbTGNQPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:15:11 -0400
Date: Mon, 14 Jul 2003 18:29:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 patch] Configure.help updates from -ac
Message-ID: <20030714162953.GN12104@fs.tum.de>
References: <200307141504.48728.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307141504.48728.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 03:04:48PM +0200, Marc-Christian Petersen wrote:
> Hi Adrian,
> 
> > the patch below adds some Configure.help entries that are in pre3-ac1
> > but are missing in -pre5.
> why do you remove such things like (only text):
> 
> -Matrox G100/G200/G400/G450/G550 support
> -Matrox I2C support
> -Matrox G450 second head support
> -Matrox unified driver multihead support
> 
> ?

It's not me, this was directly taken from -ac.

Please correct me if I'm wrong, but AFAIK these lines are used nowhere, 
they are just copies of the one-line descriptions in the Config.in 
files.

> ciao, Marc

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

