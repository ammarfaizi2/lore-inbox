Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277612AbRKFCs1>; Mon, 5 Nov 2001 21:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281442AbRKFCsR>; Mon, 5 Nov 2001 21:48:17 -0500
Received: from lego.zianet.com ([204.134.124.54]:4360 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S277612AbRKFCsB>;
	Mon, 5 Nov 2001 21:48:01 -0500
Message-ID: <3BE74D5E.9030705@zianet.com>
Date: Mon, 05 Nov 2001 19:39:26 -0700
From: Steven Spence <kwijibo@zianet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: UDMA100 and AMD 7411
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember a while back there being a thread on the
inability to set UDMA100 on the AMD 7411 chipset.
I am wondering if this was ever solved, if it was what do
I need to do to enable it.  I tried setting IGNORE word93
Validation BITS but it still registered as being UDMA33.
If there is a patch for this can someone give me a link?
I have two drives that are capable of UDMA100 and the
cable is correct for UDMA100 and it's kinda a bummer to
only run em at UDMA33.

Dual 1.2MP Athlon on a Tyan Thunder board.
2.4.14 kernel

Thanks,
Steven

