Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVDCBZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVDCBZb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 20:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVDCBZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 20:25:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26774 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261413AbVDCBZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 20:25:27 -0500
Message-ID: <424F45F0.1000504@pobox.com>
Date: Sat, 02 Apr 2005 20:25:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Liontooth <liontooth@cogweb.net>
CC: venza@brownhat.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ICS1883 LAN PHY not detected
References: <424EF19B.7030105@cogweb.net>
In-Reply-To: <424EF19B.7030105@cogweb.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Liontooth wrote:
> 0000:02:0b.0 Ethernet controller: Marvell Technology Group Ltd. Yukon 
> Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)


You want the sk98lin or skge drivers.

	Jeff


