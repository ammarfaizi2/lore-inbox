Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSLBBWm>; Sun, 1 Dec 2002 20:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSLBBWm>; Sun, 1 Dec 2002 20:22:42 -0500
Received: from web14505.mail.yahoo.com ([216.136.224.68]:3344 "HELO
	web14505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263188AbSLBBWk>; Sun, 1 Dec 2002 20:22:40 -0500
Message-ID: <20021202013005.11343.qmail@web14505.mail.yahoo.com>
Date: Sun, 1 Dec 2002 17:30:05 -0800 (PST)
From: Arun Prasad Velu <arun_linux@yahoo.com>
Subject: Allocating huge memeory in loadable kernel module
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need 200 to 500 32k buffers in my device driver,
which is a lodable kernel module.
get_free_pages failing to allocate these many buffers.
My requirement is the all these 32k buffers should be
contiguous physical memory and I need a minimum of 200
such buffers.
I'd like to know how to get get these many buffers
(physically contigous) for a loadable kernel module.

Have a nice time.
Regards
Arun


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
