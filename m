Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289065AbSAPVmf>; Wed, 16 Jan 2002 16:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287936AbSAPVkr>; Wed, 16 Jan 2002 16:40:47 -0500
Received: from mail.mbnet.fi ([194.100.160.29]:49924 "EHLO mail.mbnet.fi")
	by vger.kernel.org with ESMTP id <S287940AbSAPVjg>;
	Wed, 16 Jan 2002 16:39:36 -0500
Message-ID: <3C45F45C.5000005@mbnet.fi>
Date: Wed, 16 Jan 2002 23:45:00 +0200
From: Joonas Koivunen <rzei@mbnet.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Power off NOT working, kernel 2.4.16
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

I keep having this problem with 2.2 and 2.4 kernel series, and that is 
APM poweroff not working. I tried all possible boot time commands which 
could help me without results.

APM poweroff has actually been working with this computer, back when we 
used 2.0.36 type kernels, and that one was possibly redhat patched or 
something else, and windowses knew also how to poweroff, with mainboards 
drivers. APM poweroff seized to operate when I switched to 2.2 serie 
kernels.

My system is P2 prosessor on ASUS P2L97. cat /proc/apm tells:

1.15 1.2 0x03 0x01 0xff 0x80 -1% -1 ?

booting with debug option doesn't make apm speak more, well I dunno how 
could I provide more information.

TIA,
rzei

