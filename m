Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270572AbUJTX3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270572AbUJTX3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270278AbUJTXXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:23:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19367 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270572AbUJTXTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:19:04 -0400
Message-ID: <4176F25B.2040905@pobox.com>
Date: Wed, 20 Oct 2004 19:18:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Tscharner <starfire@dplanet.ch>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: ICH6R and PCI - E working
References: <20041020223920.604a69f0@akasha.yshara.ch>
In-Reply-To: <20041020223920.604a69f0@akasha.yshara.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Tscharner wrote:
> Hello World,
> 
> I'm about to buy a new computer and the ASUS P5GD1 mainboard looks good
> for me. My questions:
> 
> It has the Intel 915P chipset. Does it work with the current Linux
> kernel?
> 
> It has also SATA with ICH6R chiptset. The SATA Linux status report page
> says: " "looks like ICH5" support available in ata_piix ". What does
> that mean? Does it work or not?

SATA works but doesn't use spiffy new high performance features.

	Jeff



