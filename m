Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWJQTtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWJQTtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWJQTtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:49:16 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:47012 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751245AbWJQTst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:48:49 -0400
Date: Tue, 17 Oct 2006 21:47:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jens Axboe <jens.axboe@oracle.com>
cc: Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/Kconfig question regarding CONFIG_BLOCK
In-Reply-To: <20061017193645.GM7854@kernel.dk>
Message-ID: <Pine.LNX.4.61.0610172146450.928@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610172041190.30104@yvahk01.tjqt.qr>
 <200610171857.k9HIvq1M009488@turing-police.cc.vt.edu>
 <Pine.LNX.4.61.0610172119420.928@yvahk01.tjqt.qr> <20061017193645.GM7854@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Never mind, I see that some filesystems have 'depends on BLOCK' instead 
>> of being wrapped into if BLOCK. Not really consistent but whatever.
>
>Feel free to send in patches that make things more consistent.

How would you like things? if BLOCK or depends on BLOCK?
Does menuconfig/oldconfig/etc. parse the whole config structure faster 
it it done either way?

	-`J'
-- 
