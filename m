Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315332AbSEAIol>; Wed, 1 May 2002 04:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSEAIok>; Wed, 1 May 2002 04:44:40 -0400
Received: from web21503.mail.yahoo.com ([66.163.169.14]:18717 "HELO
	web21503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315332AbSEAIok>; Wed, 1 May 2002 04:44:40 -0400
Message-ID: <20020501084439.75588.qmail@web21503.mail.yahoo.com>
Date: Wed, 1 May 2002 01:44:39 -0700 (PDT)
From: Shashidhar MC <shashimc2002@yahoo.com>
Subject: System processing time
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I am using Linux 2.4.2.
I am trying to estimate the time taken by the system
to process packets at different stages. I am basically
trying to find out where the bottleneck is, in some
386 and 486 machines, while processing packets.

Can you please let me know how I could go about
finding out the time spent in processing the packet at
different stages: from the moment it is received by
the Ethernet card to the time when it is delivered to
the application. Do I have any system call / lib /
command for this? Or do we have an ioctl() for this ? 

Thanks in advance.

Regards,
-Shashidhar.


__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
