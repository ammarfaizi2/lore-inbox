Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSIJB5h>; Mon, 9 Sep 2002 21:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318730AbSIJB5h>; Mon, 9 Sep 2002 21:57:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16654 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317257AbSIJB5g>;
	Mon, 9 Sep 2002 21:57:36 -0400
Message-ID: <3D7D528C.4070503@mandrakesoft.com>
Date: Mon, 09 Sep 2002 22:01:48 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <falfaro@borak.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Wake-on-LAN/PCI Linux support
References: <1031620633.1324.34.camel@teapot>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> Hello,
> 
> Does Linux currently support Wake-on-LAN/PCI?

yes, use 'ethtool' to enable/configure wake-on support


 > I have a 3Com 3c905 TX-M
> NIC which supports wake-on-LAN and wake-on-PCI.

for 3c59x specifically, it does not (yet) implement WOL support in the 
driver

