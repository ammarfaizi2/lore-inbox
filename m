Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUHCHjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUHCHjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUHCHjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:39:44 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:18880 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265263AbUHCHjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:39:43 -0400
Date: Tue, 3 Aug 2004 09:36:06 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: dlion <dlion2005@yahoo.com.cn>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Realtek 8169 NIC driver version
Message-ID: <20040803093606.A4911@electric-eye.fr.zoreil.com>
References: <1677288031.20040803142517@yahoo.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1677288031.20040803142517@yahoo.com.cn>; from dlion2005@yahoo.com.cn on Tue, Aug 03, 2004 at 02:25:17PM +0800
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dlion <dlion2005@yahoo.com.cn> :
[...]
>   I have read some driver codes in the Linux kernel. I noticed
> that the RTL-8169 driver(r8169.c) is an older version (v1.2).
> There is a newer drivers on Realtek's website. It's version
> number is v1.6 , and it is really much better than v1.2. Why
> not merge it into official kernel realease?

It has already been merged in 2.4.x and 2.6.x. That's old history,
really.

If you experience issues with the r8169 driver in the current 2.4.x and
2.6.x kernel (be they fixed by the driver on Realtek's website or not),
I am all ears.

--
Ueimor
