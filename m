Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVFMDBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFMDBK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 23:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVFMDA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 23:00:59 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52961 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261347AbVFMDAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 23:00:24 -0400
Message-ID: <42ACF6C1.9080603@pobox.com>
Date: Sun, 12 Jun 2005 23:00:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: akpm@odsl.org, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] cciss 2.6 DMA mapping
References: <20050610195104.GA15149@beardog.cca.cpqcorp.net>
In-Reply-To: <20050610195104.GA15149@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com wrote:
> Patch removes our homegrown DMA masks and uses the ones defined in the kernel.
> This patch replaces the broken one I sent in earlier. It has been tested and works. Please discard the first submission.
> 
> Signed-off-by: Mike Miller <mike.miller@hp.com>

ACK


