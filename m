Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267637AbSLTEOI>; Thu, 19 Dec 2002 23:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267692AbSLTEOI>; Thu, 19 Dec 2002 23:14:08 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:18455 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S267637AbSLTEOH>; Thu, 19 Dec 2002 23:14:07 -0500
Message-ID: <3E029AD6.9040104@mindspring.com>
Date: Thu, 19 Dec 2002 20:21:42 -0800
From: Walt H <waltabbyh@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021213
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Adaptec 79xx support in 2.4.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I have a Tyan Thunder K7XPro based server with the onboard AIC7902 
controllers. At the present time, its is running 2.4.19 patched with 
Adaptec's source release for the SCSI support. Adaptec's drivers did not 
  seamlessly integrate into the 2.4.19 kernel. I found an old mail 
stating that support for this chipset would be added eventually. It 
doesn't appear to be added to the 2.4 series yet. Is there something I 
should be concerned about with regards to my server? The overall 
performance and stability seem fine so far, but it is a relatively new 
box with only about 1 month in production - so far so good :)

According to Justin at Adaptec, the source has been given to both Linus 
and Marcelo. I'd sure like to see it in mainline to avoid having to hack 
it in there as it stands. Thanks.

-Walt



PS. Please CC any responses as I'm not subscribed.

