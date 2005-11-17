Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVKQMAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVKQMAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 07:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVKQMAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 07:00:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38464 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750765AbVKQMAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 07:00:50 -0500
Date: Thu, 17 Nov 2005 13:02:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
Message-ID: <20051117120200.GC7787@suse.de>
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx> <20051117091308.GZ7787@suse.de> <437C4D14.1030101@drzeus.cx> <20051117093848.GA7787@suse.de> <437C5237.3080008@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437C5237.3080008@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17 2005, Pierre Ossman wrote:
> Thanks for clearing things up. Maybe someone could update 
> DMA-mapping.txt with the things you've explained to me here *hint* ;)

Most of it is block driver specific, I doubt I added much in the way of
actual DMA-mapping.txt :-)

But yeah, it's not the first time I've been asked these questions. At
least this time it was with lkml cc'ed, so I can point others at the
thread!

-- 
Jens Axboe

