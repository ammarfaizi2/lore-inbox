Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130190AbQK1CfY>; Mon, 27 Nov 2000 21:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130374AbQK1CfO>; Mon, 27 Nov 2000 21:35:14 -0500
Received: from web511.mail.yahoo.com ([216.115.104.226]:12043 "HELO
        web511.mail.yahoo.com") by vger.kernel.org with SMTP
        id <S130190AbQK1CfI>; Mon, 27 Nov 2000 21:35:08 -0500
Message-ID: <20001128020502.16003.qmail@web511.mail.yahoo.com>
Date: Mon, 27 Nov 2000 18:05:01 -0800 (PST)
From: Joe <josepha48@yahoo.com>
Reply-To: joeja@mindspring.com
Subject: out of swap
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last night I was browsing the web and I came across a page with
LOTS of images.  There were so many that it drove my swap space
to ZERO.  I still had 3 Meg of memory, but the system became
virtually unusable and SLOW. (there were over 150 x 30k+ images
on one page). 

Is this something that the OOM would fix or is this another
issue altogether?

The machine has 
64Meg of swap space, 128 Meg of RAM, Dual 233MMX, Itis running
2.2.17 and Rh 6.2.

Any ideas?  thanks Joe

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
