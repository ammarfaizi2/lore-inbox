Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbULXDpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbULXDpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 22:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbULXDpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 22:45:38 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:59800 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261363AbULXDpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 22:45:34 -0500
Subject: Re: rtc in 2.6.10rc3
From: Lee Revell <rlrevell@joe-job.com>
To: steve@perfectpc.co.nz
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0412241631220.513@localhost>
References: <Pine.LNX.4.60.0412241631220.513@localhost>
Content-Type: text/plain
Date: Thu, 23 Dec 2004 22:45:34 -0500
Message-Id: <1103859934.13482.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-24 at 16:33 +1300, steve@perfectpc.co.nz wrote:
> Just do a 'modprobe rtc' with kernel 2.6.10rc3 and got the message No such device
> of course VMware or mplayer can not use /dev/rtc.
> 
> Things normal with 2.4.27 though. What did I miss or is this a known bug in 2.6.10rc3?

The RTC works fine.  You are doing something wrong.  Probably you didn't
compile the kernel with RTC support.

Lee

