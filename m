Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131557AbQLIAfy>; Fri, 8 Dec 2000 19:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135190AbQLIAfo>; Fri, 8 Dec 2000 19:35:44 -0500
Received: from web4302.mail.yahoo.com ([216.115.104.194]:28428 "HELO
	web4302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131557AbQLIAfi>; Fri, 8 Dec 2000 19:35:38 -0500
Message-ID: <20001209000506.26629.qmail@web4302.mail.yahoo.com>
Date: Fri, 8 Dec 2000 16:05:06 -0800 (PST)
From: T R Vishwanath <trvish@yahoo.com>
Subject: Any cure for kupdate freezing ongoing  I/Os ? 
To: linux-kernel@vger.kernel.org
Cc: trvish@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running the 2.2.14 linux kernel, and doing
buffered writes to disk. Whenever kupdate runs, I
notice that the I/Os freeze up, sometimes taking 10-20
seconds to complete. Are there any patches to the
kernel to prevent thsi kind of behaviour ? I am using
the standard bdflush parameters. Is this problem
ameliorated in the 2.4 kernel ? 

 Any help on this would be greatly appreciated. Since
I am not a member of this list, could you please reply

to trvish@yahoo.com ?

Thanks
T R Vishwanath.

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
