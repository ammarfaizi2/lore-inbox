Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTKMP0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTKMP0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:26:42 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:50886 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S264324AbTKMPZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:25:53 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <RqNS.54j.11@gated-at.bofh.it>
References: <RoMa.Mi.7@gated-at.bofh.it> <RpI1.2RG.5@gated-at.bofh.it> <RqNS.54j.11@gated-at.bofh.it>
Date: Thu, 13 Nov 2003 16:05:12 +0100
Message-Id: <E1AKJ20-0006Ek-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003 15:40:20 +0100, you wrote in linux.kernel:

>> My patch from yesterday should handle that situation. 
>> cdrom_get_last_written is allowed to override the capacity from
>> cdrom_read_capacity.

> Yep, that is fine.

Will you queue the patch or should I resend it after 2.6.0 gets released?

-- 
Ciao,
Pascal
