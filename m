Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131347AbRDMOC7>; Fri, 13 Apr 2001 10:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131352AbRDMOCu>; Fri, 13 Apr 2001 10:02:50 -0400
Received: from mail.texoma.net ([209.151.96.3]:59328 "HELO mail.texoma.net")
	by vger.kernel.org with SMTP id <S131347AbRDMOCi>;
	Fri, 13 Apr 2001 10:02:38 -0400
Message-ID: <3AD706C4.8020705@texoma.net>
Date: Fri, 13 Apr 2001 09:01:40 -0500
From: Moses Mcknight <moses@texoma.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; 0.8.1) Gecko/20010323
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with k7 optimizations in 2.4.x?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I don't know if this is a problem with my hardware setup or config 
settings or what, but whenever I try to run a 2.4.x kernel on my machine 
with k7 optimizations the computer will never fully boot and seems to 
give random errors about being "unable to handle kernel NULL pointer 
dereference at virtual address xxxxxxxx" and other errors.
    This has happened with the debian 2.4.2 package and my own 
compilings of 2.4.3, 2.4.3-ac4, and 2.4.3-ac5.  If I compile it with 586 
optimizations it works fine.
    My hardware is as follows: Athlon/Thunderbird 850 Mhz CPU,
Iwill KK266 Mobo. (uses VIA kt133a chipset and 686b southbridge) with 
the latest BIOS update from fullon3d.com which is supposed to fix the 
data corruption problem, 256 MB SDRAM and IBM DTLA-307060 HD.

Thanks for any info/help.
Moses

