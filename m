Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUF0RcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUF0RcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 13:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUF0RcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 13:32:25 -0400
Received: from math.ut.ee ([193.40.5.125]:61601 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264147AbUF0RcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 13:32:24 -0400
Date: Sun, 27 Jun 2004 20:32:21 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: rtc: IRQ 0 is not free.
In-Reply-To: <Pine.LNX.4.58.0406271832350.3328@alpha.polcom.net>
Message-ID: <Pine.GSO.4.44.0406272031290.11811-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_HPET_RTC_IRQ=y
>
> to n instead of y.

Thanks. I did a review of my config options regarding HPET and disabled
them all since I don't have HPET hardare.

-- 
Meelis Roos (mroos@linux.ee)

