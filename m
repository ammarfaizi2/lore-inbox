Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWIKVyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWIKVyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWIKVyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:54:40 -0400
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:58575 "EHLO
	smtp131.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S964985AbWIKVyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:54:38 -0400
Message-ID: <4505DAFA.20802@gentoo.org>
Date: Mon, 11 Sep 2006 17:54:02 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Stian Jordet <liste@jordet.net>
CC: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, torvalds@osdl.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
References: <20060907223313.1770B7B40A0@zog.reactivated.net>	 <1157811641.6877.5.camel@localhost.localdomain>	 <4502D35E.8020802@gentoo.org>	 <1157817836.6877.52.camel@localhost.localdomain>	 <45033370.8040005@gentoo.org>	 <1157848272.6877.108.camel@localhost.localdomain>	 <450436F1.8070203@gentoo.org>	 <1157906395.23085.18.camel@localhost.localdomain>	 <4504621E.5090202@gentoo.org>	 <1157917308.23085.26.camel@localhost.localdomain>	 <1157916102.21295.9.camel@localhost.localdomain>	 <1157988809.13889.5.camel@localhost.localdomain> <1158005769.4748.0.camel@localhost.localdomain>
In-Reply-To: <1158005769.4748.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stian Jordet wrote:
>> if it is , was resolved with this [PATCH V3] VIA IRQ quirk behaviour change ? 
> 
> I have no idea what you mean here, but it's by no means fixed by that
> patch, actually it just got worse (usb didn't work, but still got
> interrupts from eth0 - and it still used irq 11)

Are you sure? The failure report you sent me was from V2 of the patch. 
V3 should work fine, based on earlier comments and info from you.

Daniel
