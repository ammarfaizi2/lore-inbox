Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLLBwo>; Mon, 11 Dec 2000 20:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLLBwe>; Mon, 11 Dec 2000 20:52:34 -0500
Received: from web10105.mail.yahoo.com ([216.136.130.55]:12559 "HELO
	web10105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129401AbQLLBwT>; Mon, 11 Dec 2000 20:52:19 -0500
Message-ID: <20001212012148.60376.qmail@web10105.mail.yahoo.com>
Date: Mon, 11 Dec 2000 17:21:48 -0800 (PST)
From: Al Peat <al_kernel@yahoo.com>
Subject: e2fs block to physical block translation
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: al_kernel@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick question about blocks:

  If I assume my hard drive uses 512 blocks, and my
ext2 filesystem uses 4k blocks, can I assume the
following formula for translation?

  physical block # / 8  =  e2fs block #

  Thanks,
  Al

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
