Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289902AbSAKIqW>; Fri, 11 Jan 2002 03:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289903AbSAKIqM>; Fri, 11 Jan 2002 03:46:12 -0500
Received: from web9208.mail.yahoo.com ([216.136.129.41]:776 "HELO
	web9208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289902AbSAKIqD>; Fri, 11 Jan 2002 03:46:03 -0500
Message-ID: <20020111084602.55532.qmail@web9208.mail.yahoo.com>
Date: Fri, 11 Jan 2002 00:46:02 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also tried 2.4.18pre3 with H5. The boot process hung in 
spawn_ksoftirqd at the kernel_thread call. 

__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
