Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUC1OKX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 09:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUC1OKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 09:10:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28302 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261812AbUC1OKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 09:10:18 -0500
Date: Sun, 28 Mar 2004 16:10:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328141014.GE24370@suse.de>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4066156F.1000805@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27 2004, Jeff Garzik wrote:
> I also wouldn't want to lock out any users who wanted to use SATA at 
> full speed ;-)

And full speed requires 32MB requests?

-- 
Jens Axboe

