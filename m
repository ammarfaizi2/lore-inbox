Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVFAFqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVFAFqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFAFqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:46:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:32133 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261277AbVFAFqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 01:46:36 -0400
Message-ID: <429D4BB3.6080903@pobox.com>
Date: Wed, 01 Jun 2005 01:46:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] AHCI PCI MSI support, update 1
References: <429C8978.4060601@pobox.com> <20050601054422.GA1441@suse.de>
In-Reply-To: <20050601054422.GA1441@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> System boots and works fine (typing this message here), MSI is enabled.
> I double checked with an added printk :-)

Any chance you could post a full /proc/interrupts output for this box?


> So that's at least one ACK for you. Now running NCQ and MSI enabled
> ahci, I'm not sure SATA gets any better!

<grin>

Thanks,

	Jeff


