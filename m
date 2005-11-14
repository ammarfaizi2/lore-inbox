Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVKNDI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVKNDI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 22:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKNDI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 22:08:27 -0500
Received: from rtr.ca ([64.26.128.89]:46467 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750781AbVKNDI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 22:08:27 -0500
Message-ID: <4377FFA7.4030400@rtr.ca>
Date: Sun, 13 Nov 2005 22:08:23 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc1: kswapd crash
References: <4377D1B2.8070003@rtr.ca> <20051114004758.GA5735@stusta.de>
In-Reply-To: <20051114004758.GA5735@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>
> Perhaps your vmware modules?

No, not those.  They've been there for years.

> Does this happen with an unpatched 2.6.15-rc1 ftp.kernel.org kernel and 
> without loading any modules not shipped with this kernel since booting?

It's only happened once so far,
but I'd only been running 2.6.15-rc1
for all of three hours to that point.

First time I've seen this since I began,
back in 1992.
