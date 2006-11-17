Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933764AbWKQSEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933764AbWKQSEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933765AbWKQSEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:04:43 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:31630 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S933763AbWKQSEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:04:42 -0500
Message-ID: <455DF9AE.3000406@garzik.org>
Date: Fri, 17 Nov 2006 13:04:30 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Peer Chen <pchen@nvidia.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Prakash Punnoor <prakash@punnoor.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Kuan Luo <kluo@nvidia.com>
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
References: <15F501D1A78BD343BE8F4D8DB854566B0CEB90E0@hkemmail01.nvidia.com>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0CEB90E0@hkemmail01.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer Chen wrote:
> I didn't get any comment from you guys for new patch, does someone take
> care this patch, do we still need some modification upon it? Or do we
> need re-submit it in other thread?

For my part, it's in my queue of things to review.  I need to figure out 
the best way to export this support.

	Jeff



