Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131400AbRAaI7o>; Wed, 31 Jan 2001 03:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131436AbRAaI7f>; Wed, 31 Jan 2001 03:59:35 -0500
Received: from [202.9.161.7] ([202.9.161.7]:3062 "HELO debian")
	by vger.kernel.org with SMTP id <S131400AbRAaI7V>;
	Wed, 31 Jan 2001 03:59:21 -0500
Message-ID: <3A77D3F1.4070206@bigfoot.com>
Date: Wed, 31 Jan 2001 14:29:29 +0530
From: archan <devrootp@bigfoot.com>
Organization: Open Source Software
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17 i686; en-US; 0.7) Gecko/20010119
X-Accept-Language: en
MIME-Version: 1.0
To: Prasanna P Subash <psubash@turbolinux.com>
Cc: John Jasen <jjasen1@umbc.edu>, Matthew Gabeler-Lee <msg2@po.cwru.edu>,
        linux-kernel@vger.kernel.org, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1 PAL_BG
In-Reply-To: <Pine.LNX.4.32.0101301830330.1138-100000@cheetah.STUDENT.cwru.edu> <Pine.SGI.4.31L.02.0101301951040.887333-100000@irix2.gl.umbc.edu> <20010130171528.B25507@turbolinux.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using "Pixel View TV tuner card" based on "bttv". It works perfect 
in Windows with default TV application, and also responding well in 
Linux 2.2.17 and 2.4.0-test10 kernel. The device is getting detected 
perfectly by 2.4 kernel but I could not be able to check whether the 
card in 2.4 kernel is responding on PAL-BG signal (here, my frequency 
table is PAL-BG, country India) as none of the Linux apps (xawtv, 
cabletv) are responding positively.

archan
devrootp@bigfoot.com
archanp@bigfoot.com

Prasanna P Subash wrote:

> I have experienced similar issues with 2.4.0 and its test. I have a bttv848 chipset.
> I even tried compiling in kdb as a part of the kernel to see if it oopses, but no luck.
> 
> I will try trying 0.7.47 today.
> 
> this works on 2.2.16, last time i tried.
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
