Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRBHIrk>; Thu, 8 Feb 2001 03:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBHIrb>; Thu, 8 Feb 2001 03:47:31 -0500
Received: from f111.law4.hotmail.com ([216.33.149.111]:4359 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129030AbRBHIrP>;
	Thu, 8 Feb 2001 03:47:15 -0500
X-Originating-IP: [207.74.111.149]
From: "Manish kochhal" <kochhal_manish@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Partitioning H/disk & triple booting for RedHat Linux 7.0 , win98 and Win2000
Date: Thu, 08 Feb 2001 08:47:08 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F111k1Ixzl4anSs21Ud00004ae9@hotmail.com>
X-OriginalArrivalTime: 08 Feb 2001 08:47:08.0911 (UTC) FILETIME=[B89D0FF0:01C091AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





>
>hi
>
>Linux Enthusiasts !
>
>I am a newbie to RedHat Linux and the partitioning stuff...
>
>I have an AMD Athlon 1.2 Ghz processor with an IBM deskstar 45 GB h/disk
>
>the system already came with Windows 98 and then I installed Windows 2000 
>and Red hat Linux 7.0
>
>However I am not able to boot linux with triple boot...I think I havent 
>partitioned the h/disk properly...For Booting into Linux using the NT 
>bootloader I modified the boot.ini file and added an entry for linux to 
>point to a file which I got from the linux console by typing
>
>dd if=/dev/hda3 bs=512 count=1 of=/root/linux.bin
>mcopy /root/linux.bin a:.
>
>However, it didnt work...I think that there are some strict requirements 
>with the /boot partition and 1024 cylinder boundary of the Windows
>
>I am not aware of it fully...Can u help me with that ?
>
>Moreover, please can u suggest how I should partition my entire Hard-disk
>I actually intend to partition the h/disk like this:
>
>20 GB to Win98
>
>13 GB to Win2000
>
>10 GB to Linux...
>
>Your Suggestions are very much needed...
>
>Thanks,
>Manish
>
>
>
>

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
