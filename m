Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTABSQj>; Thu, 2 Jan 2003 13:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbTABSQj>; Thu, 2 Jan 2003 13:16:39 -0500
Received: from jamesconeyisland.com ([66.64.43.2]:22792 "EHLO
	mail.jamesconeyisland.com") by vger.kernel.org with ESMTP
	id <S266292AbTABSQi> convert rfc822-to-8bit; Thu, 2 Jan 2003 13:16:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ron cooper <rcooper@jamesconeyisland.com>
Organization: James Coney island
To: root@micr0s0ftsux.com
Subject: Re: vanilla 2.4.20/2.4.21 doesn't boot w/ http://www.ecs.com.tw/products/pd_spec.asp?product_id=63  (L7VTARAID). vt8235 kt400(vt8377) pdc20265
Date: Thu, 2 Jan 2003 12:21:15 -0600
User-Agent: KMail/1.4.3
References: <200301021733.h02HXFwn013814@c0ns0le.net.ttu.edu>
In-Reply-To: <200301021733.h02HXFwn013814@c0ns0le.net.ttu.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301021221.15538.rcooper@jamesconeyisland.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's probably the promise controller.  Did you try disabling the promise in 
the bios to see if everything else works correctly?



On Thursday 02 January 2003 11:33 am, root@micr0s0ftsux.com wrote:
> recently purchased the following mobo and have been trying multiple
> combinations of kernels/patches to try and get this working correctly.
> currently having to use a redhat 2.4.20-2.2.rpm to get the box to boot
> correctly yet it lacks xfs support. i'm needing to know if anyone has been
> able to get this combination of devices working correctly. if you need more
> info please reply directly as well as cc.. thanks
>
> http://www.ecs.com.tw/products/pd_spec.asp?product_id=63
>
> vanilla 2.4.20: system will detect the devices and halts after VP_IDE ide1
> vanilla 2.4.21pre2: system will detect the devices and halts with
> dma_proxy_timeout:dma_status=0x64
>
>
> thanks in advance for any input.
>
> brandon

