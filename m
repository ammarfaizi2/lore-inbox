Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWBTVKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWBTVKA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWBTVKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:10:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63243 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932203AbWBTVJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:09:59 -0500
Date: Mon, 20 Feb 2006 22:09:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Patrick McHardy <kaber@trash.net>,
       Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org, dccp@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
Message-ID: <20060220210957.GH4661@stusta.de>
References: <20060220042615.5af1bddc.akpm@osdl.org> <43F9BDDA.1060508@reub.net> <43F9CE18.10709@trash.net> <43FA20C4.9090709@gmx.net> <39e6f6c70602201256s14df3079j676a88e28934d8ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e6f6c70602201256s14df3079j676a88e28934d8ef@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 05:56:47PM -0300, Arnaldo Carvalho de Melo wrote:
>...
> So perhaps something like what is done for the io schedulers, will study this...

The io schedulers solve this through "always build the noop scheduler"...

> - Arnaldo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

