Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWH3WoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWH3WoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWH3WoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:44:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:23432 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751166AbWH3WoV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:44:21 -0400
Date: Thu, 31 Aug 2006 00:43:40 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: penberg@cs.Helsinki.FI, akpm@osdl.org, dvrabel@cantab.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net, dominik.schulz@gauner.org
Subject: Re: [PATCH] IP1000A: IC Plus update 2006-08-22
Message-ID: <20060830224340.GA6248@electric-eye.fr.zoreil.com>
References: <1156268234.3622.1.camel@localhost.localdomain> <20060822232730.GA30977@electric-eye.fr.zoreil.com> <20060823113822.GA17103@electric-eye.fr.zoreil.com> <20060823223032.GA25111@electric-eye.fr.zoreil.com> <026c01c6c71d$0fde1730$4964a8c0@icplus.com.tw> <20060824220758.GA19637@electric-eye.fr.zoreil.com> <20060827220816.GA21788@electric-eye.fr.zoreil.com> <002a01c6ca43$ae73ebd0$4964a8c0@icplus.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002a01c6ca43$ae73ebd0$4964a8c0@icplus.com.tw>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> :
[...]
> Added:
> 0043-ip1000-use-the-new-IRQF_-constants-and-the-dma_-alloc-free-_coherent-AP
> I.txt
> 0044-ip1000-mixed-case-and-upper-case-removal.txt
> 0045-ip1000-add-ipg_-r-w-8-16-32-macros.txt

Added:
0046-ip1000-kiss-TxBuffDMAhandle-goodbye.txt
0047-ip1000-kiss-RxBuffDMAhandle-goodbye.txt
0048-ip1000-turn-StationAddr-0-1-2-into-an-array.txt
0049-ip1000-switch-to-classical-tx_current-tx_dirty-ring-management.txt

The previous branch for the driver at
git://electric-eye.fr.zoreil.com/home/romieu/linux-2.6.git has been stored
as 'netdev-ipg-20060831.old'. The current one is based on dc709bd and
named 'ipg'.

Nothing will be pushed tomorrow as I have some bugs to review in different
drivers.

-- 
Ueimor
