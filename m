Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVCTC2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVCTC2z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 21:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVCTC2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 21:28:55 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:62384 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261393AbVCTC2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 21:28:54 -0500
Message-ID: <423CDFC2.6050701@bigpond.net.au>
Date: Sun, 20 Mar 2005 13:28:18 +1100
From: Cal <hihone@bigpond.net.au>
Reply-To: hihone@bigpond.net.au
User-Agent: Mozilla Thunderbird 0.6+ (X11/20050122)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP boot failure, Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.099169, version=0.94.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not subscribed, so please forgive the unthreaded post.

As per K.R. Foley's report, booting on SMP fails. I tried & failed to 
capture the boot messages via serial, so the best I can offer is a pic 
of what remained visible on screen at the death.
<http://www.graggrag.com/rt/rt-V0.7.41-00-20050320.jpg>
I suspect there was more prior to that, but so far that's the best I can 
offer.

Booting with maxcpus=1 didn't fail completely, but also suffered dramas. 
Loss of usb mouse was the most noticable. If that scenario might be 
interesting or helpful, I'll pursue it further.

cheers, Cal


