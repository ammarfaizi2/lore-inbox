Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281884AbRKSCc7>; Sun, 18 Nov 2001 21:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281883AbRKSCcs>; Sun, 18 Nov 2001 21:32:48 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:781 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280024AbRKSCcm>; Sun, 18 Nov 2001 21:32:42 -0500
Message-ID: <3BF86EAA.1070605@yahoo.com>
Date: Mon, 19 Nov 2001 10:30:02 +0800
From: Zhongyu <xxx_pku@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeffrin <jeffrin@msservices.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compilation related
In-Reply-To: <15352.6424.786079.47914@jeffrin@msservices.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just delete the lines which have the 'deactivate_page' function

>Hello all,
>
>I tried to do a typical compilation of 2.4.14 related kernel
>but compilation stops.
>
>
>drivers/block/block.o: In function `lo_send':
>drivers/block/block.o(.text+0xa86f): undefined reference to
>`deactivate_page'
>drivers/block/block.o(.text+0xa8b9): undefined reference to
>`deactivate_page'
>make: *** [vmlinux] Error 1
>
> 
>




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

