Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWJUATm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWJUATm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWJUATm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:19:42 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:6881 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030205AbWJUATl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:19:41 -0400
Date: Sat, 21 Oct 2006 02:17:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
cc: Jens Axboe <jens.axboe@oracle.com>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/Kconfig question regarding CONFIG_BLOCK 
In-Reply-To: <200610210014.k9L0E3pr005019@laptop13.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.61.0610210217400.15201@yvahk01.tjqt.qr>
References: <200610210014.k9L0E3pr005019@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I'd be surprised if if BLOCK wasn't faster over, say, 10 depends on
>> BLOCK.
>
>I'd be /very/ surprised if anybody even noticed...

I am about to do a poorman's benchmark.


	-`J'
-- 
