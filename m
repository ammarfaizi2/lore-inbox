Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVLEVfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVLEVfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVLEVfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:35:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13061 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932519AbVLEVfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:35:52 -0500
Date: Mon, 5 Dec 2005 22:35:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Matt Mackall <mpm@selenic.com>, acme@conectiva.com.br,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] move some code to net/ipx/af_ipx.c
Message-ID: <20051205213550.GL9973@stusta.de>
References: <6.282480653@selenic.com> <7.282480653@selenic.com> <20051114015707.GB5735@stusta.de> <20051118052252.GG11494@stusta.de> <39e6f6c70511181224r20801b61j87c856c703ab2b4d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e6f6c70511181224r20801b61j87c856c703ab2b4d@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 06:24:10PM -0200, Arnaldo Carvalho de Melo wrote:
> On 11/18/05, Adrian Bunk <bunk@stusta.de> wrote:
> > On Mon, Nov 14, 2005 at 02:57:07AM +0100, Adrian Bunk wrote:
> > > On Fri, Nov 11, 2005 at 02:35:51AM -0600, Matt Mackall wrote:
> > > > trivial: drop unused 802.3 code if we compile without IPX
> > > >
> > > > (originally from http://wohnheim.fh-wedel.de/~joern/software/kernel/je/25/)
> 
> Thanks Adrian, from a quick glance looks OK, I'll review it later
> today to see if everything is fine wrt appletalk, tr, etc.

Any result from your review?

> - Arnaldo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

