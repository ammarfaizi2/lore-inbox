Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVJCJWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVJCJWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 05:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVJCJWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 05:22:15 -0400
Received: from web8401.mail.in.yahoo.com ([202.43.219.149]:8059 "HELO
	web8401.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932197AbVJCJWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 05:22:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=r+k3CVzgPYD07xXY1xMybJIV/aGKc0C6st9+5j8NPeegHDywJC5acO6NMQrPdHEm8vk3Pak82cU8ZhDqVT0wSDlLD0QV3yQlJanNWQ5mYBvzZ+1BRgqVRm2vrCoHCi/j0kar2thHkDqrOC4qE9xbWtpiTGQF2bYh4fTeNBdsMSs=  ;
Message-ID: <20051003092208.96452.qmail@web8401.mail.in.yahoo.com>
Date: Mon, 3 Oct 2005 10:22:08 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: 2.6.13-rc6-xx-all.diff is not working for 2.6.13 arm kernel 
To: bcrl@kvack.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ben ,

I tried to apply 2.6.13-rc6-B0/B1-all.diff to
linux-2.6.13 kernel with arm support patches . It's
getting applied cleanly...
but while building the kernel i am getting some build
errors ... 
i traced the problem and get that this error are
coming because of some machine specific files.
1)arch/i386/kernel/semaphore.c
2)include/asm-i386/seamphore.h

So can you please tell me that whather any patch is
available, in order to support these implementation on
arm platform.

Or any development is going on in this direction 


Thanks in advance

Vikas 


	

	
		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner online. Go to http://yahoo.shaadi.com
