Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbUBJTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUBJTvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:51:22 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35071 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266207AbUBJTs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:48:59 -0500
Subject: Re: 2.6.2 - System clock runs too fast
From: john stultz <johnstul@us.ibm.com>
To: Markus Hofmann <markus@gofurther.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200402101332.26552.markus@gofurther.de>
References: <200402101332.26552.markus@gofurther.de>
Content-Type: text/plain
Message-Id: <1076442533.1351.35.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 10 Feb 2004 11:48:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-10 at 04:32, Markus Hofmann wrote:
> Hello together
> 
> I've a problem with my system clock. It runs too fast. In realtime 5 minutes 
> my notebook runs 8 minutes. The BIOS-Time doesn't run.
> With kernel 2.4.24 everything is ok but when I boot my new 2.6.2 the clock 
> runs.
> 
> Could it be that the compiled speedstepping caused this problem?
> Or is there an another causing?

Could you send me your dmesg?

thanks
-john


