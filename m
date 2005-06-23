Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVFWQ72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVFWQ72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 12:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVFWQ72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 12:59:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:182 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262609AbVFWQ7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 12:59:25 -0400
Message-ID: <42BAEA67.7090606@pobox.com>
Date: Thu, 23 Jun 2005 12:59:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP+irq handling broken in current git?
References: <20050623135318.GC9768@suse.de>
In-Reply-To: <20050623135318.GC9768@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> Something strange is going on with current git as of this morning (head
> ee98689be1b054897ff17655008c3048fe88be94). On an old test box (dual p3
> 800MHz), using the same old config I always do on this box has very
> broken interrupt handling:

Does 2.6.12 work for you?
2.6.11?

I noticed a few "2.6.12 is broken, 2.6.11 works" bug reports with 
vaguely similar circumstances -- irq handling being a culprit.

	Jeff



