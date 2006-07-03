Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWGCRk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWGCRk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWGCRk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:40:29 -0400
Received: from titanium.sabren.com ([67.19.173.4]:55943 "EHLO
	titanium.sabren.com") by vger.kernel.org with ESMTP
	id S1751225AbWGCRk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:40:28 -0400
Date: Mon, 3 Jul 2006 19:40:16 +0200
From: Grzegorz Adam Hankiewicz <gradha@titanium.sabren.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Allen Martin <AMartin@nvidia.com>
Subject: Re: Linux kernel 2.6.10 sata_nv.c stops working on my hardware
Message-ID: <20060703174016.GA8904@noir>
Reply-To: linux-kernel@vger.kernel.org
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Allen Martin <AMartin@nvidia.com>
References: <20060702133125.GB2606@noir> <DBFABB80F7FD3143A911F9E6CFD477B014AD8D80@hqemmail02.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B014AD8D80@hqemmail02.nvidia.com>
X-Accept-Language: es,en
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-07-02, Allen Martin <AMartin@nvidia.com> wrote:
> Can you try 2.6.13 with 2.6.12 libata and the sata_nv with
> ATA_FLAG_SATA_RESET?  Probably the thing that changed in 2.6.13
> that made your system unhappy was in libata.

Shouldn't I see the changes between 2.6.9 and 2.6.10 which is
when the ATA_FLAG_SATA_RESET flag was removed, and thus the kernel
stopped working on the system?

> What was the model number of your SATA drive?  SATA_RESET shouldn't
> really be necessary if the drive is well behaving.

Maxtor 300GB sata I, 6V300F0 - VA111630 - V60EA5F6 and 6V300F0 -
VA111630 - V60EYSY6. Is this the info you wanted?
