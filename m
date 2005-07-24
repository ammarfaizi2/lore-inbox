Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVGXVqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVGXVqp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 17:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVGXVqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 17:46:45 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:36576 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261389AbVGXVqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 17:46:42 -0400
Date: Sun, 24 Jul 2005 23:46:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ciprian <cipicip@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 speed
In-Reply-To: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0507242345320.9022@yvahk01.tjqt.qr>
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I got a question for you. Apparently kernel 2.6 is
>much slower then 2.4 and about 30 times slower then
>the windows one.
>
>I'm not an OS guru, but I ran a little and very simple
>test. The program bellow, as you can see, measures the
>number of cycles performed in 30 seconds.

I suggest that you take out the time stuff and measure the whole running time, 
at the shell level.
Under Linux you can do that using "time ./myprog" - how you do it under 
Windows is another concern, but you can write a small "time" program for 
windows, too.


Jan Engelhardt
-- 
