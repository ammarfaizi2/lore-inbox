Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWCBVqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWCBVqF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWCBVqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:46:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27922 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932590AbWCBVqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:46:03 -0500
Date: Thu, 2 Mar 2006 22:46:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dtor_core@ameritech.net,
       jgeorgas@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060302214602.GJ9295@stusta.de>
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au> <20060302173840.GB9295@stusta.de> <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com> <20060302203245.GD9295@stusta.de> <9a8748490603021240t31f58ea4ycafae4ee8a12095c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490603021240t31f58ea4ycafae4ee8a12095c@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 09:40:17PM +0100, Jesper Juhl wrote:
> On 3/2/06, Adrian Bunk <bunk@stusta.de> wrote:
> >
> > We do not have to export symbols we don't want to export to modules but
> > needed by CONFIG_UNIX.
> >
> 
> I'm probably exposing my ignorance here, but, what symbols would those be?
>...

  http://lkml.org/lkml/2006/2/18/44

> Jesper Juhl <jesper.juhl@gmail.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

