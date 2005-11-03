Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVKCHja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVKCHja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 02:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVKCHja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 02:39:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43330 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750700AbVKCHja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 02:39:30 -0500
Date: Thu, 3 Nov 2005 08:37:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/ll_rw_blk.c: make a function static
Message-ID: <20051103073720.GU26049@suse.de>
References: <20051102181549.GD4272@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102181549.GD4272@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02 2005, Adrian Bunk wrote:
> This patch makes a needlessly global function static.

Applied, but please make the subject (and body) more descriptive in the
future.

-- 
Jens Axboe

