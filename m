Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129875AbQK0QSL>; Mon, 27 Nov 2000 11:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129950AbQK0QSB>; Mon, 27 Nov 2000 11:18:01 -0500
Received: from web310.mail.yahoo.com ([216.115.105.75]:17166 "HELO
        web310.mail.yahoo.com") by vger.kernel.org with SMTP
        id <S129875AbQK0QRt>; Mon, 27 Nov 2000 11:17:49 -0500
Message-ID: <20001127154743.27705.qmail@web310.mail.yahoo.com>
Date: Mon, 27 Nov 2000 07:47:43 -0800 (PST)
From: Kaustubh Phanse <ksphanse@yahoo.com>
Subject: Error after make bzImage
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

      I am trying to recompile my kernel after adding
some patches... After making the changes, I first run
make dep and then make clean...both run fine. However,
after running make bzImage it gives me the following
errors:

make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory
`/usr/src/linux-2.2.16/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory
`/usr/src/linux-2.2.16/kernel'
make: *** [_dir_kernel] Error 2                      

I was not able to figure out what may be causing this
problem. Can some one please help me out with this
one?

Thank you very much
Kaustubh

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
