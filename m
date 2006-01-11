Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWAKOhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWAKOhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWAKOhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:37:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53600 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932397AbWAKOhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:37:20 -0500
Date: Wed, 11 Jan 2006 15:39:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cleanup cdrom_ioctl
Message-ID: <20060111143917.GQ3389@suse.de>
References: <20060111131717.GA9491@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111131717.GA9491@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11 2006, Christoph Hellwig wrote:
> add a small helper for each ioctl to cut down cdrom_ioctl to a readable
> size.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Jens Axboe <axboe@suse.de>

Can you send them to Andrew for -mm, please?

-- 
Jens Axboe

