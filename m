Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135440AbRBERLR>; Mon, 5 Feb 2001 12:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130005AbRBERLH>; Mon, 5 Feb 2001 12:11:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41225 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135440AbRBERKx>;
	Mon, 5 Feb 2001 12:10:53 -0500
Date: Mon, 5 Feb 2001 18:10:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: patch: loop-4
Message-ID: <20010205181046.O5285@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just put up a (hopefully) final version of the loop patch,
this time against 2.4.2-pre1. I'd like people to give this
a good beating again, and also _please_ test if you have
crypto loop stuff from 2.2. If nothing bad shows up, I'll
be submitting this shortly.

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.2-pre1/loop-4

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
