Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWCEQaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWCEQaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 11:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWCEQaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 11:30:21 -0500
Received: from mail.dvmed.net ([216.237.124.58]:58323 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932205AbWCEQaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 11:30:20 -0500
Message-ID: <440B121A.80007@garzik.org>
Date: Sun, 05 Mar 2006 11:30:18 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthieu CASTET <castet.matthieu@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
References: <Pine.LNX.4.61.0603041945520.29991@yvahk01.tjqt.qr> <20060304.134144.122314124.davem@davemloft.net> <200603041705.41990.gene.heskett@verizon.net> <20060304.141643.04633220.davem@davemloft.net> <pan.2006.03.05.16.14.19.327190@free.fr>
In-Reply-To: <pan.2006.03.05.16.14.19.327190@free.fr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu CASTET wrote:
> But we need a special driver ?
> The IOAT driver from intel seems to expect a pci device (0x8086 0x1a38)
> and the common x86 computer have their dma in lpc/isa bridge.

The common x86 computer does not have -asynchronous- DMA.

	Jeff


