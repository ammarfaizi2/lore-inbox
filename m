Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUBPH0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 02:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbUBPH0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 02:26:37 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:7699 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S265383AbUBPH0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 02:26:35 -0500
Subject: Re: system (not HW) clock advancing really fast
From: Bill Anderson <banderson@hp.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200402161424.49242.mhf@linuxmail.org>
References: <1076910368.25980.12.camel@perseus>
	 <200402161424.49242.mhf@linuxmail.org>
Content-Type: text/plain
Message-Id: <1076916391.25980.23.camel@perseus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 16 Feb 2004 00:26:31 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2004 07:26:32.0811 (UTC) FILETIME=[33B503B0:01C3F45E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-15 at 23:24, Michael Frank wrote:
> I had this somtetimes when using ntpd doing step time update
> resulting in silly values in /etc/adjtime . 
> 
> # mv /etc/adjtime /tmp 
> # hwclock --systohc
> 
> and see if it goes away.

Thanks, though it didn't work. :(

-- 
Bill Anderson <banderson@hp.com>
Red Hat Certified Engineer

