Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968360AbWLEE5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968360AbWLEE5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 23:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968362AbWLEE5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 23:57:01 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:42368 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968357AbWLEE5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 23:57:00 -0500
Message-ID: <4574FC0A.8090607@garzik.org>
Date: Mon, 04 Dec 2006 23:56:42 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: -mm merge plans for 2.6.20
References: <20061204204024.2401148d.akpm@osdl.org>
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> via-pata-controller-xfer-fixes.patch
> via-pata-controller-xfer-fixes-fix.patch

Tejun's 3d3cca37559e3ab2b574eda11ed5207ccdb8980a has been ack'd by the 
reporter as fixing things, so these two shouldn't be needed.


> libata_resume_fix.patch

I thought this was resolved long ago?  Are there still open reports that 
this solves, where upstream doesn't work?


> ahci-ati-sb600-sata-support-for-various-modes.patch

With the PCI quirk, I thought ATI was finally sorted?

	Jeff


