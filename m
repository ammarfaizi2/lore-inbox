Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136109AbREIKke>; Wed, 9 May 2001 06:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136113AbREIKkZ>; Wed, 9 May 2001 06:40:25 -0400
Received: from gw.netgem.com ([195.154.83.69]:8709 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id <S136109AbREIKkO>;
	Wed, 9 May 2001 06:40:14 -0400
Message-ID: <3AF91E88.1000705@netgem.com>
Date: Wed, 09 May 2001 10:40:08 +0000
From: Jocelyn Mayer <jma@netgem.com>
Organization: Netgem S.A.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: antonpoon@hongkong.com, linux-kernel@vger.kernel.org
Subject: Re: How to compile kernel for Geode GX1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >  Hi,

 > How can I compile a kernel that would be running on a National 
Semiconductor Geode GX1 processor?

 > I wish to be personally CC'ed the answers/comments posted to the list 
in response to my posting. Thank you.

 > Best Regards,
 > Anton

Well, you can select '(586/K5/5x86/6x86/6x86MX) Processor family '
in the  'Processor type and features ' menu of menuconfig.

That's what I do for a Geode GXLv,
and it works with 2.2 and 2.4 kernels.
There is one version (maybe more ?),
I think 2.4.1, which cannot boot on Cyrix,
but others works well...

Regards.


