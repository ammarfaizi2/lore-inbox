Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUB1Sr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 13:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbUB1Sr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 13:47:58 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:30619 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261900AbUB1Sr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 13:47:56 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Date: Sat, 28 Feb 2004 18:47:52 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 - 8139too timeout debug info
Message-ID: <4040E258.29625.299F47FC@localhost>
In-reply-to: <87znb3t83c.fsf@devron.myhome.or.jp>
References: <403F7EEF.4124.2432E62F@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If I use the 8139too.c from 2.6.2, and build 2.6.3 with it, all works 
> > fine (I am running this version right now).
> 
> Interesting.
> 
> Please try the attached patch for debugging. After this problem
> happen, send the all output of dmesg, all .config, and "cat /proc/interrupts".
> 
> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Thanks for your help.  I have hell of a trouble doing this, as soon 
as any network load happens, the box becomes unresponsive during 
timeouts - but hopefully I have caught the info required.

http://www.linicks.net/8139too_debug/

Thanks,

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

