Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUC1N7S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 08:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUC1N7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 08:59:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15756 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261787AbUC1N7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 08:59:17 -0500
Date: Sun, 28 Mar 2004 15:59:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328135907.GC24370@suse.de>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040327170257.24c82915.akpm@osdl.org> <406625D4.7090605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406625D4.7090605@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27 2004, Jeff Garzik wrote:
> "IOPs" are what make a lot of storage peeps excited these days, so they 
> are being pushed in a low-latency direction anyway.

IOPS says nothing about latency, it's still 100% throughput oriented.

-- 
Jens Axboe

