Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWITIPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWITIPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 04:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWITIPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 04:15:50 -0400
Received: from science.horizon.com ([192.35.100.1]:40514 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750710AbWITIPu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 04:15:50 -0400
Date: 20 Sep 2006 04:15:41 -0400
Message-ID: <20060920081541.23336.qmail@science.horizon.com>
From: linux@horizon.com
To: sergio@sergiomb.no-ip.org
Subject: Re: Math-emu kills the kernel on Athlon64 X2
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fine :),  My (12 year old) 486DX2 already don't need Math-emu. I just
> don't see how in a computer like that will be installed a kernel 2.6 .
> So why code of math-emu isn't dropped ? 

Google for "386EX".  There are any number of embedded boards
based on an this FPU-less 386 which people like to run Linux on.

There's more to the world than personal computers; the fact that the
Linux kernel runs almost unmodified on most of the largest computers in
the world (http://www.top500.org/stats/27/os/) and some of the dinkiest
(http://www.research.ibm.com/WearableComputing/linuxwatch/linuxwatch.html)
is a source of considerable pride.
