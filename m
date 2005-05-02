Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVEBQ3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVEBQ3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVEBQ2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:28:32 -0400
Received: from verein.lst.de ([213.95.11.210]:43935 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261447AbVEBQVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:21:11 -0400
Date: Mon, 2 May 2005 18:20:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andi Kleen <ak@muc.de>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] {,un}register_ioctl32_conversion should have been removed last month
Message-ID: <20050502162057.GA4056@lst.de>
References: <20050502014550.GG3592@stusta.de> <20050502160916.GE27150@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502160916.GE27150@muc.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 06:09:16PM +0200, Andi Kleen wrote:
> On Mon, May 02, 2005 at 03:45:51AM +0200, Adrian Bunk wrote:
> > This removal should have happened last month.
> 
> Thanks. I believe I2O and s390 are still using it though. The I2O patch
> is pending somewhere and s390 will hopefully catch up. 

both i2o and s390 have been converted away from it in mainline.

