Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263766AbRFIEXT>; Sat, 9 Jun 2001 00:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263772AbRFIEXJ>; Sat, 9 Jun 2001 00:23:09 -0400
Received: from mail.digitalme.com ([193.97.97.75]:2712 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S263766AbRFIEW7>;
	Sat, 9 Jun 2001 00:22:59 -0400
Message-ID: <3B21A4F7.6040303@digitalme.com>
Date: Sat, 09 Jun 2001 00:24:23 -0400
From: "Trever L. Adams" <vichu@digitalme.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9.1+) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: cramfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hate to ask this, however here goes.  I am doing some remote upgrading 
and some other really funky stuff to some boxes I keep up.

Part of these are total system upgrades and I need to move data out of 
the way while still having a working box.  I decided that cramfs may be 
the way to do this.  If you can tell me no and point me to a resource on 
how to do this, I would LOVE to hear about it.

However, the question is, how can I tell lilo to tell the kernel too 
boot off a cramfs file system?  I have already created the file with 
/etc /bin /sbin /dev and /lib from a working system, doing the correct 
deletions and other such changes.  I have a 15 meg cramfs that should do 
the trick.

Thank you for any help you can offer.

Trever Adams

