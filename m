Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbSK2MXb>; Fri, 29 Nov 2002 07:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbSK2MXb>; Fri, 29 Nov 2002 07:23:31 -0500
Received: from web14609.mail.yahoo.com ([216.136.224.241]:43787 "HELO
	web14609.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267029AbSK2MXa>; Fri, 29 Nov 2002 07:23:30 -0500
Message-ID: <20021129123052.61297.qmail@web14609.mail.yahoo.com>
Date: Fri, 29 Nov 2002 04:30:52 -0800 (PST)
From: Super user <lnxuser2002@yahoo.com>
Subject: Size limitation for the module
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1021119124918.4890A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a kernel module which is a huge one. Around 1.5
MB. Is there any known problems in having a such a big
module.

The problem is after inserting the module, the box
freezes after some time. Some times it crashes.I
analyzed the oops message, but it does'nt make much
sense, since the trace leads me to some other kernel
code. So it looks like my module is corrupting the
memory , which leads to this crash.Appreciate if
someone can send me a link to fix these types of
problems. Also is there any tool which can do a
memwatch on the kernel space.

Thanks,
lnxuser2002.

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
