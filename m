Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135684AbREIVsv>; Wed, 9 May 2001 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135685AbREIVsm>; Wed, 9 May 2001 17:48:42 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:9738 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S135684AbREIVsd>; Wed, 9 May 2001 17:48:33 -0400
Message-ID: <3AF9D8EF.4020605@eisenstein.dk>
Date: Thu, 10 May 2001 01:55:27 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: MCradiolists: line 2: syntax error near unexpected token
In-Reply-To: <E14xbcH-0003LC-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>> I just unpacked a fresh copy of 2.4.4 and patched it to 2.4.5pre1 and 
>> ran into a problem. When I attempt to change the type (through 
>> menuconfig) of CPU to compile for, the following gets dumped to the 
>> console:
> 
> 
> Grab the menuconfig diff from the -ac patches . Menuconfig had a bug in 
> bracket handling the new config file tripped

I extracted the menuconfig related parts from 2.4.4-ac6 and applied them 
- with 100% success... I can now select the CPU type.

Thank you!


Best regards,
Jesper Juhl - juhl@eisenstein.dk

