Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWDTOku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWDTOku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWDTOku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:40:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64005 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750798AbWDTOku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:40:50 -0400
Date: Thu, 20 Apr 2006 15:43:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] block/elevator.c: remove unused exports
Message-ID: <20060420134342.GA4717@suse.de>
References: <20060413162216.GB4162@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413162216.GB4162@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13 2006, Adrian Bunk wrote:
> This patch removes the following unused EXPORT_SYMBOL's:
> - elv_requeue_request
> - elv_completed_request
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

-- 
Jens Axboe

