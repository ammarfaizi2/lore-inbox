Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbRGYC3m>; Tue, 24 Jul 2001 22:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266469AbRGYC3d>; Tue, 24 Jul 2001 22:29:33 -0400
Received: from zeus.kernel.org ([209.10.41.242]:29833 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S266464AbRGYC3U>;
	Tue, 24 Jul 2001 22:29:20 -0400
Date: Tue, 24 Jul 2001 19:28:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Alan Cox <laughing@shared-source.org>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c update to 2.6.0 for 2.4.7
Message-ID: <20010724192805.A695@opus.bloom.county>
In-Reply-To: <20010725024629.E2308@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010725024629.E2308@werewolf.able.es>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 25, 2001 at 02:46:29AM +0200, J . A . Magallon wrote:
> Hi.
> 
> This patch updates i2c support in kernel to 2.6.0. I have corrected original patch
> to use slab.h instead of malloc.h, a couple #endif's, and Comfigure.help references
> to other docs in <file:...> format.

It appears to be missing new files.  The rpx and 405 bits aren't all there.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
