Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757051AbWK0Fvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757051AbWK0Fvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757052AbWK0Fvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:51:39 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:13456 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1757049AbWK0Fvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:51:38 -0500
Date: Mon, 27 Nov 2006 08:48:19 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] better CONFIG_W1_SLAVE_DS2433_CRC handling
Message-ID: <20061127054819.GB15600@2ka.mipt.ru>
References: <20061126013503.GE15364@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061126013503.GE15364@stusta.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 27 Nov 2006 08:48:20 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 02:35:03AM +0100, Adrian Bunk (bunk@stusta.de) wrote:
> CONFIG_W1_SLAVE_DS2433_CRC can be used directly, there's no reason for 
> the indirection of defining a different variable in the Makefile.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I will add apply this patch, thanks Adrian.

-- 
	Evgeniy Polyakov
