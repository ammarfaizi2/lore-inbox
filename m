Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRDOD0S>; Sat, 14 Apr 2001 23:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132568AbRDOD0H>; Sat, 14 Apr 2001 23:26:07 -0400
Received: from mail.texoma.net ([209.151.96.3]:10231 "HELO mail.texoma.net")
	by vger.kernel.org with SMTP id <S132556AbRDODZ4>;
	Sat, 14 Apr 2001 23:25:56 -0400
Message-ID: <3AD91491.1050906@texoma.net>
Date: Sat, 14 Apr 2001 22:25:05 -0500
From: Moses Mcknight <moses@texoma.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; 0.8.1) Gecko/20010323
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Athlon runtime problems
In-Reply-To: <E14oRie-000556-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Can the folks who are seeing crashes running athlon optimised kernels all mail
> me
> 
> -	CPU model/stepping

AMD Athlon Thunderbird 850Mhz
Stepping - 2


> -	Chipset

VIA KT133A chipset, Iwill KK266 MB.
According to a couple other people this problem may only occur on this 
motherboard.


> -	Amount of RAM

256 MB Corsair PC150


> -	/proc/mtrr output

reg: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg: base=0xd5000000 (3408MB), size=  16MB: write-combining, count=1


> -	compiler used

2.95.3 - Debian unstable package.


> 
> Alan

When these errors occur, I never get to a shell prompt.  Is there a way 
to save the errors or have them saved somewhere so I don't have to write 
all that stuff down?  Also, how can I set the console buffer (what is it 
called, where you can view previous screens with SHIFT + PgUP/DOWN?) to 
hold more so I don't lose some of the errors?

Thanks,
Moses


