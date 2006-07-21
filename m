Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWGUMN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWGUMN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 08:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWGUMN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 08:13:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54565 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161060AbWGUMNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 08:13:55 -0400
Date: Fri, 21 Jul 2006 14:13:53 +0200
From: Jens Axboe <axboe@suse.de>
To: takis@issaris.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Conversions from kmalloc+memset to k(z|c)alloc
Message-ID: <20060721121352.GB25045@suse.de>
References: <20060721113210.GB11822@issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060721113210.GB11822@issaris.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21 2006, takis@issaris.org wrote:
> From: Panagiotis Issaris <takis@issaris.org>
> 
> block: Conversions from kmalloc+memset to kzalloc

They are already done in the block git repo.

-- 
Jens Axboe

