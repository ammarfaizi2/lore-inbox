Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUBZSaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUBZSaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:30:19 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:15030 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262873AbUBZSaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:30:12 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 26 Feb 2004 18:30:10 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 RT8139too NIC problems [NOT resolved]
Message-ID: <403E3B32.1845.1F424323@localhost>
In-reply-to: <20040226101330.20190d34@dell_ss3.pdx.osdl.net>
References: <403E34F8.31130.1F29EF00@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > yes, that is the pre-NAPI driver. You seem to be the only one having
> problems with the NAPI driver, so please help getting it fixed.
> 

OK, please what do I need to do?  I did build with debug, but dmesg 
gets filled up so fast I have lost the logs.  Also, when I do use the 
new 8139too.c driver, the box (my gateway) is unusable for any type 
of network traffic load.

So I will need to do it in one hit to grab the info and switch back 
again.

Thanks for reply - I want to help and reolve this too...

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble,
Give a whistle
And this'll help things turn out for the best."

