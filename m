Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129589AbQKKDZN>; Fri, 10 Nov 2000 22:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129587AbQKKDZD>; Fri, 10 Nov 2000 22:25:03 -0500
Received: from [202.103.134.10] ([202.103.134.10]:64441 "HELO mx1.netease.com")
	by vger.kernel.org with SMTP id <S129198AbQKKDY4>;
	Fri, 10 Nov 2000 22:24:56 -0500
Date: Sat, 11 Nov 2000 11:25:32 +0800
From: Nick Cheng <grandsolo@netease.com>
Reply-To: grandsolo@sina.com
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: newbie in kernel
Organization: Lejie Network Service Co. Ltd
X-mailer: FoxMail 3.0 beta 2 [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20001111033012.E4BAC1C860F83@mx1.netease.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sirs,
   May I have your help on re-build kernel?
   I wanna find /usr/src/linux/include/linux/tasks.h and change the NR_TASKS to increase the limitation of max processes. But It's not there under kernel 2.4.0-test10. where can I find it?
   All I wanna get, is to increate the max processes and max_open files under 2.4.0-test10.
   I've changed my OPEN_MAX to 1024 in limits.h . is it 1024 the max under 2.4.0?
   I don't know is this mail right to the linux-kernel maillist. If it's wrong, Say sorry to you and please ignore this mail.
   Thanks and sorry to bother you! 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
