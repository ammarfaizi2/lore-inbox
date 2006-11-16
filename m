Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161865AbWKPGNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161865AbWKPGNO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 01:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031076AbWKPGNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 01:13:14 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57772 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031015AbWKPGNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 01:13:14 -0500
Message-ID: <455C0176.5090107@garzik.org>
Date: Thu, 16 Nov 2006 01:13:10 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: David Miller <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <455A938A.4060002@garzik.org>	 <20061114.201549.69019823.davem@davemloft.net> <455A9664.50404@garzik.org>	 <20061114.202814.70218466.davem@davemloft.net>	 <1163643937.5940.342.camel@localhost.localdomain>	 <455BDA1D.5090409@garzik.org> <1163650341.5940.361.camel@localhost.localdomain>
In-Reply-To: <1163650341.5940.361.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>> We are referring to the standard PCI 2.2 bit, PCI_COMMAND_INTX_DISABLE.
> 
> Yeah, I figured it, I somewhat forgot about it ... it got introduced in
> 2.3 though, no ?

It's pretty new.  2.2 or 2.3.

	Jeff



