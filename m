Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271787AbRIMPyz>; Thu, 13 Sep 2001 11:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271803AbRIMPyq>; Thu, 13 Sep 2001 11:54:46 -0400
Received: from babel.spoiled.org ([212.84.234.227]:22140 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S271787AbRIMPyf>;
	Thu, 13 Sep 2001 11:54:35 -0400
Date: 13 Sep 2001 15:54:57 -0000
Message-ID: <20010913155457.27151.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: chris@boojiboy.eorbit.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <200109130124.SAA22845@boojiboy.eorbit.net>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200109130124.SAA22845@boojiboy.eorbit.net> you wrote:
>> > When my bios is set ACPI=NO, and APM is compiled in:
>> > A 'shutdown -r' hangs after the "Restarting System" message.  
>> > Depressing the power switch cause a power off.
>> 
>> Try "Use real mode APM BIOS call to power off".
> 
> With 2.4.9-ac9 'shutdown -r' does not work.  The
> halt '-h' flag does work.  '-r' hangs at "Restarting System."

You may try to use the kernel-option "reboot=bios".

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

