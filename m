Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbULXDdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbULXDdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 22:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbULXDdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 22:33:40 -0500
Received: from smtpout3.compass.net.nz ([203.97.97.135]:50139 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S261358AbULXDdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 22:33:39 -0500
Date: Fri, 24 Dec 2004 16:33:32 +1300 (NZDT)
From: steve@perfectpc.co.nz
X-X-Sender: sk@localhost
Reply-To: steve@perfectpc.co.nz
To: linux-kernel@vger.kernel.org
Subject: rtc in 2.6.10rc3
Message-ID: <Pine.LNX.4.60.0412241631220.513@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Just do a 'modprobe rtc' with kernel 2.6.10rc3 and got the message No such device
of course VMware or mplayer can not use /dev/rtc.

Things normal with 2.4.27 though. What did I miss or is this a known bug in 2.6.10rc3?

please help.


Steve Kieu
