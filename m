Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288485AbSA1JLS>; Mon, 28 Jan 2002 04:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289115AbSA1JLI>; Mon, 28 Jan 2002 04:11:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33803 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288485AbSA1JK4>;
	Mon, 28 Jan 2002 04:10:56 -0500
Date: Mon, 28 Jan 2002 10:10:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] sd-many for 2.4.18-pre7 (uses devfs)
Message-ID: <20020128101035.B8894@suse.de>
In-Reply-To: <200201280326.g0S3QTt27080@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201280326.g0S3QTt27080@vindaloo.ras.ucalgary.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27 2002, Richard Gooch wrote:
>   Hi, all. Appended is my sd-many patch. It supports up to 2080
> SD's. This patch is against 2.4.18-pre7, and is essentially the same
> as earlier versions of this patch, just compensating for kernel drift.

Richard,

Could you please at least try to follow the style in sd? To me, this
alone is reason enough why the patch should not be applied.

-- 
Jens Axboe

