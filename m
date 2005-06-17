Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVFQXEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVFQXEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 19:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVFQXE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 19:04:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:61327 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261708AbVFQXEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 19:04:25 -0400
Message-ID: <42B356EC.6060600@pobox.com>
Date: Fri, 17 Jun 2005 19:04:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] cciss 2.6: pci id fix
References: <20050617183451.GB9913@beardog.cca.cpqcorp.net>
In-Reply-To: <20050617183451.GB9913@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com wrote:
> This patch fixes a PCI ID I got wrong before. It also adds support for another
> new SAS controller due out this summer. I didn't have a marketing name prior
> to my last submission.
> Also modifies the copyright date range.
> 
> Please consider this for inclusion.
> 
> Signed-off-by: Mike Miller <mike.miller@hp.com>

ACK for:

this patch
PCI domain pass 2
remove partition info

patches.

	Jeff


