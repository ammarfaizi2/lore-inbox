Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266654AbSLDOuJ>; Wed, 4 Dec 2002 09:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSLDOuJ>; Wed, 4 Dec 2002 09:50:09 -0500
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:64667 "EHLO
	nx5.HRZ.Uni-Dortmund.DE") by vger.kernel.org with ESMTP
	id <S266654AbSLDOuI>; Wed, 4 Dec 2002 09:50:08 -0500
Message-ID: <3DEE1596.1060803@mathematik.uni-dortmund.de>
Date: Wed, 04 Dec 2002 15:47:50 +0100
From: Michael Abshoff <Michael.Abshoff@mathematik.uni-dortmund.de>
Reply-To: Michael.Abshoff@mathematik.uni-dortmund.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh
MIME-Version: 1.0
To: Alex Bennee <alex@braddahead.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ctrl-Alt-Backspace kills machine not X. ACPI?
References: <1039005946.2366.25.camel@cambridge.braddahead>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bennee wrote:

>Hi,
>
>I've been running into problems with my machine locking up in X but
>however I have been unable to diagnose it because the Ctrl-Alt-Backspace
>key sequence kills my whole machine (i.e. powers it down).
>
>I've done some searching on google but haven't been able to find any
>references except a one errata note for Mandrake that mentions disabling
>the APIC which I tried and had no effect.
>
>The Ctrl-Alt-Backspace sequence will power down my machine at any point
>(BIOS Self-test, Grub, Console mode or X) but doesn't to it once Windows
>is running. I have a suspicion that this is ACPI related but even with
>acpi=off and apm=off flags is can still stop the box which can't be
>right. Any pointers? I stand ready to provide any additional data.
>
>  
>
Hello,

do you use an SIS-Board by any chance. The is a Bios-Option that powers 
down
the system. Disabeling it had no affect on my mashine, but there may be 
a Bios
update available.

I was also told that resetting the Bios via jumper might help.

Michael

-- 
Michael Abshoff - MRB - Universität Dortmund - Telefon 755-3463 (intern)

   Where do you want to RTFM today?



