Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbRG2BXk>; Sat, 28 Jul 2001 21:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267419AbRG2BXa>; Sat, 28 Jul 2001 21:23:30 -0400
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:19451 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S267268AbRG2BXN>; Sat, 28 Jul 2001 21:23:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steve Snyder <swsnyder@home.com>
Reply-To: swsnyder@home.com
To: linux-kernel@vger.kernel.org
Subject: What does "Neighbour table overflow" message indicate?
Date: Sat, 28 Jul 2001 20:23:14 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072820231401.01125@mercury.snydernet.lan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I just got this sequence of messages in my system log:

Jul 28 19:47:44 sunburn kernel: Neighbour table overflow.
Jul 28 19:47:44 sunburn last message repeated 9 times
Jul 28 19:47:49 sunburn kernel: NET: 53 messages suppressed.
Jul 28 19:47:49 sunburn kernel: Neighbour table overflow.
Jul 28 19:48:07 sunburn kernel: NET: 21 messages suppressed.
Jul 28 19:48:07 sunburn kernel: Neighbour table overflow.
Jul 28 19:48:09 sunburn last message repeated 3 times
Jul 28 19:48:14 sunburn kernel: NET: 4 messages suppressed.
Jul 28 19:48:14 sunburn kernel: Neighbour table overflow.

This is on a RedHat v7.1 + SMP kernel v2.4.7 system.  What is the kernel 
trying to tell me here?

Please cc me as I am not a subscriber to this list.

Thanks.
