Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUB1KAW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 05:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUB1KAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 05:00:22 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:28940 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261175AbUB1KAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 05:00:21 -0500
Date: Sat, 28 Feb 2004 10:00:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kurt Garloff <kurt@garloff.de>, ching@tekram.com.tw,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] tmscsim: remove kernel kenel 2.2 #ifdef's
Message-ID: <20040228100017.A10822@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, Kurt Garloff <kurt@garloff.de>,
	ching@tekram.com.tw, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20040228094732.GL5499@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040228094732.GL5499@fs.tum.de>; from bunk@fs.tum.de on Sat, Feb 28, 2004 at 10:47:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 10:47:33AM +0100, Adrian Bunk wrote:
> The patch below removes #ifdefs for kernel 2.0 and 2.2 from the tmscsim 
> driver.

There's currently lots of patches for this driver pending, I'd rather
wait with these cleanups after they're in.

