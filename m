Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267673AbTBJLCH>; Mon, 10 Feb 2003 06:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTBJLCH>; Mon, 10 Feb 2003 06:02:07 -0500
Received: from web20406.mail.yahoo.com ([66.163.169.94]:28707 "HELO
	web20418.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267673AbTBJLCG>; Mon, 10 Feb 2003 06:02:06 -0500
Message-ID: <20030210111151.31800.qmail@web20418.mail.yahoo.com>
Date: Mon, 10 Feb 2003 03:11:51 -0800 (PST)
From: devnetfs <devnetfs@yahoo.com>
Subject: compiling kernel with debug and optimization
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Does compiling with -g option degrade performance? IMO it should NOT.

If that's true, then why dont we compile kernels with both -g and -O2
always? Also does using -g AND -O2 cause some optimizations to be 
missed out?

Thanks in advance,

Regards,
A.

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
