Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263595AbRFNSLh>; Thu, 14 Jun 2001 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263597AbRFNSL1>; Thu, 14 Jun 2001 14:11:27 -0400
Received: from [212.18.228.90] ([212.18.228.90]:49170 "HELO
	carrot.linuxgrrls.org") by vger.kernel.org with SMTP
	id <S263595AbRFNSLQ>; Thu, 14 Jun 2001 14:11:16 -0400
Message-ID: <3B28FE41.8010908@linuxgrrls.org>
Date: Thu, 14 Jun 2001 19:11:13 +0100
From: Rachel Greenham <rachel@linuxgrrls.org>
Organization: LinuxGrrls.Org
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac6 i686; en-US; rv:0.9.1) Gecko/20010607 Netscape6/6.1b1
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Monniaux <monniaux_nospam@arbouse.ens.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: more on VIA 686B (trials)
In-Reply-To: <20010614194402.A19960@picsou.chatons>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Monniaux wrote:

>I replaced this mobo+Duron with an ASUS A7V133+Athlon, which
>work perfectly well.
>Athlon-optimized kernel, UDMA100, no problem whatsoever.
>
Which is odd, because that's exactly my combination (ASUS A7V133 + 
Athlon), and I get crashes with DMA on anything from 2.4.3-ac7 onwards, 
but up to 2.4.3-ac6 is rock-steady. (my crash test is "bonnie -s 1024" 
:-)) I wonder what's different between our machines (apart from distro, 
which I wouldn't expect to be relevant)? Clock speed? We tried 
downclocking my Athlon to 1.0 GHz but it made no difference.

I've been tinkering (have no kernel programming experience) with 
selectively forward-porting the 2.4.3-ac6 code to newer kernels for my 
own use at least, but haven't got it right yet.

-- 
Rachel


