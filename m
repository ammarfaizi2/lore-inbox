Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbTA1JWo>; Tue, 28 Jan 2003 04:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbTA1JWo>; Tue, 28 Jan 2003 04:22:44 -0500
Received: from mta04bw.bigpond.com ([139.134.6.87]:53955 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S264614AbTA1JWn> convert rfc822-to-8bit; Tue, 28 Jan 2003 04:22:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Solved 2.4.21-pre3aa1 and RAID-0 issue (was: Re: 2.4.21-pre3aa1 and RAID0 issue]
Date: Tue, 28 Jan 2003 20:46:58 +1100
User-Agent: KMail/1.4.3
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200212270856.13419.harisri@bigpond.com> <200301271441.11112.harisri@bigpond.com> <20030127113002.GB889@suse.de>
In-Reply-To: <20030127113002.GB889@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301282046.58473.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

On Monday 27 January 2003 22:30, Jens Axboe wrote:
> Could you please try this patch on top of 2.4.21-pre3aa1 instead of
> backing out blk-atomic? Does that work, too? Thanks!

Yes, the RAID-0 works fine on 2.4.21-pre3aa1 after applying your patch on top 
of it.

Thanks.
-- 
Hari
harisri@bigpond.com

