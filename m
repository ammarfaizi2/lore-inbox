Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSLXP7l>; Tue, 24 Dec 2002 10:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLXP7l>; Tue, 24 Dec 2002 10:59:41 -0500
Received: from [203.199.93.15] ([203.199.93.15]:3602 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S265236AbSLXP7k>; Tue, 24 Dec 2002 10:59:40 -0500
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200212241600.VAA29047@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: Lowering Latency
Date: Tue, 24 Dec 2002 21:25:46 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm writing a module device driver on RH 8.0 (2.4.18-14 kernel).
I'd like to know is there any way I can give maximum priority to my module.
Or can I make my module a non-preemptable one?
I could see from drivers/char/oprofile/compat.h that preempt_disable() doesn't do anything. (Mine is an uniprocessor machine.)
I don't want to touch the rest of the kernel. I dont want to apply any patch.
All I want to do is get the maximum time from the CPU and lower my driver's latency.
Is it possible?
If it's possible, please do let me know, how to achieve this.

Wishing you all a merry christmas and a prosperous new year.

Arun


Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy the best in Movies at http://www.videos.indiatimes.com

Now bid just 7 Days in Advance and get Huge Discounts on Indian Airlines Flights. So log on to http://indianairlines.indiatimes.com and Bid Now!

