Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVFTVKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVFTVKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVFTVH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:07:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54946 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261541AbVFTVCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:02:23 -0400
Message-ID: <42B72EDC.6040707@pobox.com>
Date: Mon, 20 Jun 2005 17:02:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Samsung SN-124 works perfectly well with DMA
References: <1119298324.3304.29.camel@localhost.localdomain>
In-Reply-To: <1119298324.3304.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Been in Red Hat products for ages
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Can you provide a similar patch for ata_dma_blacklist[] in libata-core.c?

	Jeff


