Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264373AbRFLNUg>; Tue, 12 Jun 2001 09:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264392AbRFLNU0>; Tue, 12 Jun 2001 09:20:26 -0400
Received: from [212.18.228.90] ([212.18.228.90]:61714 "HELO
	carrot.linuxgrrls.org") by vger.kernel.org with SMTP
	id <S264373AbRFLNUO>; Tue, 12 Jun 2001 09:20:14 -0400
Message-ID: <3B2616E7.5020508@linuxgrrls.org>
Date: Tue, 12 Jun 2001 14:19:35 +0100
From: Rachel Greenham <rachel@linuxgrrls.org>
Organization: LinuxGrrls.Org
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac6 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christian =?ISO-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
In-Reply-To: <3B2606CF.10003@linuxgrrls.org> <001901c0f33d$1a4c8170$3303a8c0@einstein>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:

>>CPU: Athlon 1.33 GHz with 266MHz FSB
>>Mobo: Asus A7V133 with 266MHz FSB, UltraDMA100 (PDC20265 according to
>>
>
>So you put your IBM drive on the promise, right?
>

Oh yes. :-)

>
>Removing the hard disc from the promise controller and attaching it on the
>VIA-Controller solved my problems. The system is now rock solid. If you do
>so, take care that your root partition moves from hde to hda. Prepare a boot
>disk and pass a parameter like root=/dev/hda to the kernel. After a
>successful boot, modify fstab and lilo.conf and run lilo.
>
Yeah, OTOH I'm also happy for the time being running 2.4.3 (actually 
2.4.3-ac6 right now) which is OK at full-speed UDMA5, until the problem 
is fixed. Just thought people might like to know. :-)

>sounds absoluty identical to my problem with ASUS A7V133 I reported some
>weeks ago.
>
I only just joined, to report this - I did scan the archives though, and 
saw a lot of *older* discussion of VIA problems, but didn't see anything 
that definitely said it was still there after the 2.4.3-ac7 fixes, so 
wasn't sure if anyone was on the case. :-)

-- 
Rachel


