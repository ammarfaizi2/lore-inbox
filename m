Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbRGUQpu>; Sat, 21 Jul 2001 12:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267738AbRGUQpk>; Sat, 21 Jul 2001 12:45:40 -0400
Received: from web13908.mail.yahoo.com ([216.136.175.71]:30726 "HELO
	web13908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267732AbRGUQpd>; Sat, 21 Jul 2001 12:45:33 -0400
Message-ID: <20010721164538.16010.qmail@web13908.mail.yahoo.com>
Date: Sat, 21 Jul 2001 09:45:38 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: about alim15x3 ide driver
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi, all,

I meet problem about Ali 1535D alim15x3 ide driver.
Because our hardware bug in mips evaluation board,
I can not use DMA mode in alim15x3.c, I have to
use PIO mode. In 2.2.12, I just modify ali15x3_dmaproc
function, and can support PIO directly.
I do not know how to support only PIO mode for
alim15x3 under 2.4.3 kernel.
If someone knows, please help me. Thanks!

Barry

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
