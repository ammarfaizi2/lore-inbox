Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbUKORLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbUKORLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbUKORK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:10:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16063 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261649AbUKORKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:10:00 -0500
Message-ID: <4198E2DB.5010800@pobox.com>
Date: Mon, 15 Nov 2004 12:09:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Zhu, Yi" <yi.zhu@intel.com>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: [netdrvr] netdev-2.6 queue updated
References: <3ACA40606221794F80A5670F0AF15F8403BD583B@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD583B@pdsmsx403>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhu, Yi wrote:
> Jeff Garzik wrote:
> 
>>The most notable thing is the addition of HostAP.
> 
> 
> How about move HostAP 802.11 stack and crypt related files to
> net/80211? It is generic and some other drivers (i.e. ipw2100) share
> the code. Do you receive patches to do this?


Jouni mentioned he wanted to do a few things before we started renaming?

I would like someone at Intel to submit the ipw drivers, and start 
working on them via the wireless-2.6 tree eventually[1]

	Jeff


[1] once we have permission to put the firmware in the kernel

