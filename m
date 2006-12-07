Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032107AbWLGMTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032107AbWLGMTN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032102AbWLGMTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:19:13 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37286 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032099AbWLGMTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:19:12 -0500
Message-ID: <457806BC.5070109@pobox.com>
Date: Thu, 07 Dec 2006 07:19:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] pata_it8213: Add new driver for the IT8213 card.
References: <20061204164931.7d36d744@localhost.localdomain>
In-Reply-To: <20061204164931.7d36d744@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Add a driver for the IT8213 which is a single channel ICH-ish PATA
> controller. As it is very different to the IT8211/2 it gets its own
> driver. There is a legacy drivers/ide driver also available and I'll post
> that once I get time to test it all out (probably early January). If
> anyone else needs the drivers/ide driver and wants to do the merge for
> drivers/ide (Bart ??) then I'll forward it.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

ACK.  I believe Andrew added some cleanups which I should want?


