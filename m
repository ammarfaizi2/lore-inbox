Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVLERUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVLERUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVLERUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:20:40 -0500
Received: from mail.dvmed.net ([216.237.124.58]:4235 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751387AbVLERUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:20:39 -0500
Message-ID: <439476E4.5060003@pobox.com>
Date: Mon, 05 Dec 2005 12:20:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Volk <volk.christian@netcom-sicherheitstechnik.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: No Hotplug with AHCI (Intel ICH6M) Kernel 2.6.15rc4
References: <01c301c5f982$d8ddb3c0$0c016696@EW12>
In-Reply-To: <01c301c5f982$d8ddb3c0$0c016696@EW12>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Christian Volk wrote: > Kernel 2.6.15rc4 > I am testing
	the hotplug feature with the Intel ICH6M Chipset and a SATA > harddisk.
	> > I want to use the AHCI driver, because it should support
	hotplugging. > As you can see, the driver is loadet and the chipset was
	found correctly. > When I detach the harddisk, there are no
	kernelmessages indicating hotplug. > The only messages I can see are
	timeouts from the kernel when writing to > disk(see logfile) > Maybe is
	it a bug, that the unplugged harddisk is not detected? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Volk wrote:
> Kernel 2.6.15rc4
> I am testing the hotplug feature with the Intel ICH6M Chipset and a SATA
> harddisk.
> 
> I want to use the AHCI driver, because it should support hotplugging.
> As you can see, the driver is loadet and the chipset was found correctly.
> When I detach the harddisk, there are no kernelmessages indicating hotplug.
> The only messages I can see are timeouts from the kernel when writing to
> disk(see logfile)
> Maybe is it a bug, that the unplugged harddisk is not detected?

http://linux.yyz.us/sata/software-status.html#hotplug

	Jeff

