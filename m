Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTAFVuO>; Mon, 6 Jan 2003 16:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267223AbTAFVuO>; Mon, 6 Jan 2003 16:50:14 -0500
Received: from web20202.mail.yahoo.com ([216.136.226.57]:5517 "HELO
	web20202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267222AbTAFVuM>; Mon, 6 Jan 2003 16:50:12 -0500
Message-ID: <20030106215849.99128.qmail@web20202.mail.yahoo.com>
Date: Mon, 6 Jan 2003 13:58:49 -0800 (PST)
From: Lenny G Arbage <alengarbage@yahoo.com>
Subject: bandwidth throttling at link level
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I want to do bandwidth throttling at the link layer
in a manner similar to netshaper, but am wondering if
the netif_stop_queue functionality can be accessed
from userspace via an ioctl or other means.  That is,
without writing a line of kernel-space code, is there
a way to set the busy flag (tbusy) on a generic
ethernet device from user space?

  Thanks,
  -Lenny

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
