Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVKWVlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVKWVlG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVKWVlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:41:05 -0500
Received: from mail.dvmed.net ([216.237.124.58]:62597 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932547AbVKWVlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:41:01 -0500
Message-ID: <4384E1E9.2070309@pobox.com>
Date: Wed, 23 Nov 2005 16:40:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rolandd@cisco.com>
CC: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
References: <437D2DED.5030602@pobox.com>	<Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>	<20051118215209.GA9425@havoc.gtf.org> <52veyp39hs.fsf@cisco.com>
In-Reply-To: <52veyp39hs.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Roland Dreier wrote: > Jeff> Yes, for both 50xx and
	60xx, I had to turn off MSI in order > Jeff> to get sata_mv to work...
	> > Sounds like MSI is broken in the Marvell chip. This is exactly the
	No, it could be any one of [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Jeff> Yes, for both 50xx and 60xx, I had to turn off MSI in order
>     Jeff> to get sata_mv to work...
> 
> Sounds like MSI is broken in the Marvell chip.  This is exactly the

No, it could be any one of

* broken Marvell chip
* broken system
* driver bug

It hasn't been narrowed down yet.

	Jeff



