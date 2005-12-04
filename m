Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVLDTdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVLDTdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 14:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVLDTdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 14:33:24 -0500
Received: from mail.dvmed.net ([216.237.124.58]:31106 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932312AbVLDTdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 14:33:23 -0500
Message-ID: <4393447E.3020003@pobox.com>
Date: Sun, 04 Dec 2005 14:33:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] remove code for WIRELESS_EXT < 18
References: <20051203122720.GF31395@stusta.de>
In-Reply-To: <20051203122720.GF31395@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Adrian Bunk wrote: > WIRELESS_EXT < 18 will never be
	true in the kernel. > > > Signed-off-by: Adrian Bunk <bunk@stusta.de> >
	> --- > > drivers/net/wireless/ipw2100.c | 434 >
	drivers/net/wireless/tiacx/acx_struct.h | 5 >
	drivers/net/wireless/tiacx/common.c | 4 >
	drivers/net/wireless/tiacx/conv.c | 2 >
	drivers/net/wireless/tiacx/ioctl.c | 441 >
	drivers/net/wireless/tiacx/pci.c | 8 > drivers/net/wireless/tiacx/usb.c
	| 6 > drivers/net/wireless/tiacx/wlan.c | 2 >
	drivers/net/wireless/tiacx/wlan_compat.h | 9 > 9 files changed, 1
	insertion(+), 910 deletions(-) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> WIRELESS_EXT < 18 will never be true in the kernel.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/net/wireless/ipw2100.c           |  434 ----------------------
>  drivers/net/wireless/tiacx/acx_struct.h  |    5 
>  drivers/net/wireless/tiacx/common.c      |    4 
>  drivers/net/wireless/tiacx/conv.c        |    2 
>  drivers/net/wireless/tiacx/ioctl.c       |  441 -----------------------
>  drivers/net/wireless/tiacx/pci.c         |    8 
>  drivers/net/wireless/tiacx/usb.c         |    6 
>  drivers/net/wireless/tiacx/wlan.c        |    2 
>  drivers/net/wireless/tiacx/wlan_compat.h |    9 
>  9 files changed, 1 insertion(+), 910 deletions(-)

NAK, patches non-existent files.

[jgarzik@pretzel linux-2.6]$ ls drivers/net/wireless/tiacx
ls: drivers/net/wireless/tiacx: No such file or directory

