Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWAKOhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWAKOhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWAKOhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:37:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62304 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932400AbWAKOhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:37:32 -0500
Date: Wed, 11 Jan 2006 15:39:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kill cdrom ->dev_ioctl method
Message-ID: <20060111143930.GR3389@suse.de>
References: <20060111131901.GB9491@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111131901.GB9491@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11 2006, Christoph Hellwig wrote:
> Since early 2.4.x all cdrom drivers implement the block_device methods
> themselves, so they can handle additional ioctls directly instead of
> going through the cdrom layer.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

