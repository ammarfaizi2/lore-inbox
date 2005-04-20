Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVDTL4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVDTL4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVDTL4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:56:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23258 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261249AbVDTL4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:56:47 -0400
Date: Wed, 20 Apr 2005 13:55:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc2 00/04] blk: generic tag support fixes
Message-ID: <20050420115520.GG18758@suse.de>
References: <20050420114041.F2FA00DB@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420114041.F2FA00DB@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20 2005, Tejun Heo wrote:
>  Hello, Jens.
> 
>  These are fixes to generic tag support in the blk layer.  They all
> compile okay and I've proof read it, but as I don't have any HBA which
> uses generic tag support, I wasn't able to test directly.  However,
> all changes are fairly straight-forward.

All patches look good, thanks!

-- 
Jens Axboe

