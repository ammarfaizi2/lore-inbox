Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUKQV7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUKQV7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUKQVMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:12:41 -0500
Received: from atorelbas03.hp.com ([156.153.255.237]:25987 "EHLO
	palrel12.hp.com") by vger.kernel.org with ESMTP id S262609AbUKQVKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:10:05 -0500
Date: Wed, 17 Nov 2004 13:09:54 -0800
From: Grant Grundler <iod00d@hp.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       grant.grundler@hp.com, charlie.brett@hp.com
Subject: Re: [patch 2.6.10-rc2] tulip: make tulip_stop_rxtx() wait for DMA to fully stop
Message-ID: <20041117210954.GH4422@cup.hp.com>
References: <20041117151244.B31363@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117151244.B31363@tuxdriver.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 03:12:44PM -0500, John W. Linville wrote:
> tulip_stop_rxtx() doesn't wait for DMA to fully stop like the function
> call name implies.
> 
> Acked-by: Grant Grundler <grant.grundler@hp.com>

John,
I can provide a proper:
	Signed-off-by: Grant Grundler <iod00d@hp.com>

ditto for the 2.4.28 version of the patch.

> This was submitted through my employer -- I am not the original author
> of this patch.  However, I passed it by Jeff Garizk and he expressed
> interest in having it upstream.

Excellent!

thanks,
grant
