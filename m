Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129204AbQKEKAn>; Sun, 5 Nov 2000 05:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQKEKAd>; Sun, 5 Nov 2000 05:00:33 -0500
Received: from smtp.abac.com ([216.55.128.5]:10247 "EHLO smtp.abac.com")
	by vger.kernel.org with ESMTP id <S129204AbQKEKAT>;
	Sun, 5 Nov 2000 05:00:19 -0500
Message-ID: <3A052FA9.50802@abac.com>
Date: Sun, 05 Nov 2000 02:00:09 -0800
From: Jeremiah Savage <jeremiahsavage@abac.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test8 i686; en-US; m18) Gecko/20001103
X-Accept-Language: en
MIME-Version: 1.0
To: kladi@z.zgs.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 does not boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Dittrich wrote:
 > [1.] Kernel 2.4.0-test10 does not boot
 > [2.] I installed 2.4.0-test10 in the same manner and on the same disk
 > I did with 2.4.0-test8 which boots an runs.
 > I use an ASUS-P2B-DS with 2xPII-350 and BIOS 1013BETA005.
 > After rebooting the last message is "Uncompressing the kernel .." and
 > then the system hangs.
 > I have read that using dma by default made trouble so I made a new
 > kernel without this feature but with the same bad result.
 >
 > [3.] Kernel 2.4.0-test10


I've had the same problem with an ASUS-P2B PII-400 system.
2.4.0test8 is able to boot, but test9 and test10 do not.
I'm running current Debian/Woody:
	gcc_2.95.2	
	libc6_2.1.96	
	binutils_2.10.0.27
	make_3.79.1


Jeremiah
(not subscribed)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
