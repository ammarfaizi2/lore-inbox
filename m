Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbRCBC6e>; Thu, 1 Mar 2001 21:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130292AbRCBC6Z>; Thu, 1 Mar 2001 21:58:25 -0500
Received: from [61.153.1.177] ([61.153.1.177]:7947 "EHLO mail.viasoft.com.cn")
	by vger.kernel.org with ESMTP id <S130290AbRCBC6P>;
	Thu, 1 Mar 2001 21:58:15 -0500
Date: Fri, 2 Mar 2001 11:05:50 +0800
From: linuxjob <linuxjob@163.net>
X-Mailer: The Bat! (v1.48f) Personal
Reply-To: linuxjob <linuxjob@163.net>
X-Priority: 3 (Normal)
Message-ID: <1978548522.20010302110550@163.net>
To: Hans Reiser <reiser@namesys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
In-Reply-To: <3A9D891C.434E3AA7@namesys.com>
In-Reply-To: <3A9D891C.434E3AA7@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

Thursday, March 01, 2001, 7:26:20 AM, you wrote:

HR> I have a client that wants to implement a webcache, but is very leery of
HR> implementing it on Linux rather than BSD.

HR> They know that iMimic's polymix performance on Linux 2.2.* is half what it is on
HR> BSD.  Has the Linux 2.4 networking code caught up to BSD?

HR> Can I tell them not to worry about the Linux networking code strangling their
HR> webcache product's performance, or not?

HR> Hans
HR> -
HR> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
HR> the body of a message to majordomo@vger.kernel.org
HR> More majordomo info at  http://vger.kernel.org/majordomo-info.html
HR> Please read the FAQ at  http://www.tux.org/lkml/

It is not only related to TCP/IP performance. it is related to whole
OS performance. especially performance of file system and stablity,
network driver performance etc.
FreeBSD with softupdates turned on seems horrible fast and stable.
but Linux 2.4 is horrible fast in TCP/IP too. diffcult to compare between
in Linux and FreeBSD. don't do such stupid thing. you'll never get a
correct result.

-- 
Best regards,
David Xu


