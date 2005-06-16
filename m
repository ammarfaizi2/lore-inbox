Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVFPG4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVFPG4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 02:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVFPG4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 02:56:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26563 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261162AbVFPG4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 02:56:20 -0400
Date: Thu, 16 Jun 2005 08:57:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.12-rc6-mm1] blk: kill elevator_global_init()
Message-ID: <20050616065729.GB1483@suse.de>
References: <20050616033950.GA26870@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616033950.GA26870@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16 2005, Tejun Heo wrote:
>  Hello, Jens.
>  Hello, Andrew.
> 
>  This patch kills elevator_global_init() in elevator.c which does
> nothing.

Heh, it did something at some point in time :)

-- 
Jens Axboe

