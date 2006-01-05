Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWAES5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWAES5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWAES53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:57:29 -0500
Received: from mail.dvmed.net ([216.237.124.58]:53667 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751893AbWAES52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:57:28 -0500
Message-ID: <43BD6C03.2080605@pobox.com>
Date: Thu, 05 Jan 2006 13:57:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: saw@saw.sw.com.sg, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
References: <20060105181826.GD12313@stusta.de>
In-Reply-To: <20060105181826.GD12313@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Adrian Bunk wrote: > This patch removes the obsolete
	drivers/net/eepro100.c driver. > > Is there any known problem in e100
	still preventing us from removing > this driver (it seems noone was
	able anymore to verify the ARM problem)? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch removes the obsolete drivers/net/eepro100.c driver.
> 
> Is there any known problem in e100 still preventing us from removing 
> this driver (it seems noone was able anymore to verify the ARM problem)?

Still waiting to see if e100 in -mm works on ARM.

	Jeff



