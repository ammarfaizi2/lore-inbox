Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWJIKIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWJIKIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 06:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWJIKIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 06:08:23 -0400
Received: from brick.kernel.dk ([62.242.22.158]:64850 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751758AbWJIKIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 06:08:23 -0400
Date: Mon, 9 Oct 2006 12:08:19 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Vasily Tarasov <vtaras@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block layer: useless elevator_type field in elevator_type structure
Message-ID: <20061009100819.GQ8814@kernel.dk>
References: <200610091006.k99A6X7I032599@vass.7ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610091006.k99A6X7I032599@vass.7ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09 2006, Vasily Tarasov wrote:
> elevator_type field in elevator_type structure is useless:
> it isn't used anywhere in kernel sources.

Thanks, queued.

-- 
Jens Axboe

