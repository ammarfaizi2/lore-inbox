Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUBZIvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 03:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUBZIvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 03:51:19 -0500
Received: from adsl-b3-196-142.telepac.pt ([213.13.196.142]:60170 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S262744AbUBZIvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 03:51:16 -0500
Message-ID: <403DB381.6060701@vgertech.com>
Date: Thu, 26 Feb 2004 08:51:13 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org>
In-Reply-To: <20040225185536.57b56716.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After make modules_install, I got these:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.3-mm4; fi
WARNING: /lib/modules/2.6.3-mm4/kernel/net/ipv6/ipv6.ko needs unknown 
symbol sysctl_optmem_max
WARNING: /lib/modules/2.6.3-mm4/kernel/drivers/i2c/busses/i2c-elektor.ko 
needs unknown symbol cli
WARNING: /lib/modules/2.6.3-mm4/kernel/drivers/i2c/busses/i2c-elektor.ko 
needs unknown symbol sti
WARNING: /lib/modules/2.6.3-mm4/kernel/drivers/net/typhoon.ko needs 
unknown symbol direct_csum_partial_copy_generic

Thanks,
Nuno Silva
