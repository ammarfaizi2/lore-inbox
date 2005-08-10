Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVHJNKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVHJNKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVHJNKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:10:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43975 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965098AbVHJNKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:10:45 -0400
Date: Wed, 10 Aug 2005 15:10:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dmitry pervushin <dpervushin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi
Message-ID: <20050810131034.GA2035@elf.ucw.cz>
References: <1121025679.3008.10.camel@spirit> <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +menu "SPI support"
> +
> +config SPI
> +	default Y
> +	tristate "SPI support"
> +        default false
> +	help
> +	  Say Y if you need to enable SPI support on your kernel

I'd expect explanation what "SPI" means somewhere around here...
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
