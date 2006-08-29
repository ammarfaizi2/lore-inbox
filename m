Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWH2IMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWH2IMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWH2IMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:12:36 -0400
Received: from brick.kernel.dk ([62.242.22.158]:52532 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751259AbWH2IMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:12:34 -0400
Date: Tue, 29 Aug 2006 10:15:18 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: megaraid_sas suspend ok, resume oops
Message-ID: <20060829081518.GD12257@kernel.dk>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29 2006, Jeff Chua wrote:
> Anyone working on suspend/resume for the Megaraid SAS RAID card?
> 
> This is on a DELL 2950.
> 
> Suspend/resume (to disk) has been running great on my IBM x60s, but
> when I tried the same kernel (2.6.18-rc4) on the DELL 2950, it
> suspended ok, but when resuming, the megaraid driver crashed.

And what exactly is your intention with this email? It can't be getting
the bug fixed, since there's exactly 0% information to help people doing
so :-)

IOW, provide the oops from the resume crash at least.

-- 
Jens Axboe

