Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282481AbRLAXc7>; Sat, 1 Dec 2001 18:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282487AbRLAXct>; Sat, 1 Dec 2001 18:32:49 -0500
Received: from web10002.mail.yahoo.com ([216.136.130.38]:63868 "HELO
	web10002.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282481AbRLAXcf>; Sat, 1 Dec 2001 18:32:35 -0500
Message-ID: <20011201233234.38472.qmail@web10002.mail.yahoo.com>
Date: Sat, 1 Dec 2001 15:32:34 -0800 (PST)
From: saher es <sushey@yahoo.com>
Subject: Page/Buffer Caches Question
To: linux-kernel@vger.kernel.org
Cc: sushey@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

plz CC the reply to sushey@yahoo.com since i'm not
subscried.

My questions:
1. Are the buffer cache and the page cache connected
somehow? Does every write to the disk pass through the
buffer cache and if no what uses does the bufer cache
have now ... (kernel >= 2.4)

2. As i saw in the source code reading a page (if not
in the page cache) is done from the disk directly ...
have i missed something ?

3. Few articles i've read claimed that Buffer Cache
and Page cashe are 2 cache levels ... is that right
for kernel >= 2.4 ?

Thanks alot in advance,
Its very important for me to understand these things
:)

sushey

__________________________________________________
Do You Yahoo!?
Buy the perfect holiday gifts at Yahoo! Shopping.
http://shopping.yahoo.com
