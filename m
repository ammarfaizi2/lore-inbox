Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271577AbRHPPrb>; Thu, 16 Aug 2001 11:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271579AbRHPPrV>; Thu, 16 Aug 2001 11:47:21 -0400
Received: from Bf824.pppool.de ([213.7.248.36]:39082 "HELO localhost")
	by vger.kernel.org with SMTP id <S271578AbRHPPrK>;
	Thu, 16 Aug 2001 11:47:10 -0400
Date: Thu, 16 Aug 2001 17:47:17 +0200 (CEST)
From: Peter Koellner <peter@mezzo.net>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.8-ac5] Another Sony Vaio laptop with a broken APM...
In-Reply-To: <20010816173420.J8473@come.alcove-fr>
Message-ID: <Pine.LNX.4.21.0108161738390.8142-100000@finnegan.do.mezzo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Stelian Pop wrote:

> However, the Vaio bioses list is getting bigger and bigger
> and I wonder if there is _any_ Vaio laptop that gets this
> item right. If not, we could just do a search on SYS_VENDOR /
> PRODUCT_NAME strings, like the is_sony_vaio_laptop test...
> 
> Comments ?

at least you got one with apm battery support at all, which is not the 
case with lots of newer vaio laptops. if my observation is right,
sony and phoenix are about to remove apm support in the NoteBIOS
completely. most of the latest FX models seem to have their APM bios
completely broken.

-- 
peter koellner <peter@mezzo.net>


