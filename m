Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWDUMqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWDUMqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWDUMqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:46:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:9950 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750710AbWDUMqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:46:46 -0400
Date: Fri, 21 Apr 2006 14:46:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikado <mikado4vn@gmail.com>
cc: "'Linux kernel'" <linux-kernel@vger.kernel.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Mike Galbraith <efault@gmx.de>, Hua Zhong <hzhong@gmail.com>
Subject: Re: Which process is associated with process ID 0 (swapper)
In-Reply-To: <44481571.4000208@gmail.com>
Message-ID: <Pine.LNX.4.61.0604211446250.23180@yvahk01.tjqt.qr>
References: <004801c664c7$e80acfd0$853d010a@nuitysystems.com>
 <Pine.LNX.4.61.0604210019440.28841@yvahk01.tjqt.qr> <44481571.4000208@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Swapper is the idle process, which swaps nothing. Its name is historic and it doesn't appear in /proc because for_each_process()
>>> skips it.
>>>
>> Anyone objecting to renaming it?
>
>Please focus on my main question. Thank you!
>
Hey, you're not the only one on this list.



Jan Engelhardt
-- 
