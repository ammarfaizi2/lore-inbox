Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbUKHRBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUKHRBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUKHQ6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:58:31 -0500
Received: from nwd2mail2.analog.com ([137.71.25.51]:13494 "EHLO
	nwd2mail2.analog.com") by vger.kernel.org with ESMTP
	id S261915AbUKHPtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:49:15 -0500
Message-Id: <6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Mon, 08 Nov 2004 07:49:09 -0800
To: linux-kernel@vger.kernel.org
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: USB-Serial fails with USB 2.0 Hub
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Two problems with kernel 2.6.4 (SuSe 9.1):

1) When I use a Belkin F5U409 usb-serial converter:
     - when plugged directly into chipset (Intel ICH5), works great.
     - when plugged in through a USB 1.0 hub, works great
     - when plugged in throught USB 2.0 Hub (Belkin F5U237), fails.
       Failure mechanism is: Tx works, Rx does not.

Any further info someone needs, or thoughts?

Thanks

