Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUF0QdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUF0QdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 12:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUF0QdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 12:33:24 -0400
Received: from [80.72.36.106] ([80.72.36.106]:38317 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264061AbUF0QdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 12:33:23 -0400
Date: Sun, 27 Jun 2004 18:33:20 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: rtc: IRQ 0 is not free.
In-Reply-To: <Pine.GSO.4.44.0406271719340.11811-100000@math.ut.ee>
Message-ID: <Pine.LNX.4.58.0406271832350.3328@alpha.polcom.net>
References: <Pine.GSO.4.44.0406271719340.11811-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just set:

CONFIG_HPET_RTC_IRQ=y

to n instead of y.


Grzegorz Kulewski

