Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLATX0>; Fri, 1 Dec 2000 14:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLATXR>; Fri, 1 Dec 2000 14:23:17 -0500
Received: from web10105.mail.yahoo.com ([216.136.130.55]:12808 "HELO
	web10105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129319AbQLATXG>; Fri, 1 Dec 2000 14:23:06 -0500
Message-ID: <20001201185235.44106.qmail@web10105.mail.yahoo.com>
Date: Fri, 1 Dec 2000 10:52:35 -0800 (PST)
From: Al Peat <al_kernel@yahoo.com>
Subject: put/get_module_symbol vs. inter_module_register/put/get/etc.
To: linux-kernel@vger.kernel.org
Cc: al_kernel@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I've followed the thread on "Persistent module
storage" but haven't come across a general explanation
of the changes to the inter-module symbol stuff
between 2.4test10 and test11.  Anyone care to comment
on the differences or on whether this is going to be a
stable API for 2.4 (it won't be changed again)?


__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
