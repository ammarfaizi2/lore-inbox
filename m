Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWIZSTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWIZSTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 14:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWIZSTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 14:19:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:29587 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751271AbWIZSTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 14:19:08 -0400
Subject: Re: 2.6.18 Nasty Lockup
From: john stultz <johnstul@us.ibm.com>
To: Greg Schafer <gschafer@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060926123640.GA7826@tigers.local>
References: <20060926123640.GA7826@tigers.local>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 11:18:02 -0700
Message-Id: <1159294682.8648.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 22:36 +1000, Greg Schafer wrote:
> This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> completely dead machine with only option the reset button. Usually happens
> within a couple of minutes of desktop use but is 100% reproducible. Problem
> is still there in a fresh checkout of current Linus git tree (post 2.6.18).
> 
> Dual Athlon-MP 2200's on a Tyan S2466 Tiger MPX. Config attached.

Thanks for narrowing this down. Could you send me full dmesg output?

thanks
-john


