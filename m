Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269235AbTCBQ3G>; Sun, 2 Mar 2003 11:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269237AbTCBQ3G>; Sun, 2 Mar 2003 11:29:06 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:6908 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S269235AbTCBQ3F>;
	Sun, 2 Mar 2003 11:29:05 -0500
Message-ID: <3E6232F4.70808@tin.it>
Date: Sun, 02 Mar 2003 17:36:04 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IO APIC + ACPI Problems.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all, I report this Bug that I've found.

In my configuration  (MSI KT4 Ultra, Athlon 2400+, Geforce 3 Ti200 ) IO 
APIC doesn't give problems (  Only the UNEXPECTED IO APIC message and a 
problem about "Buggy MP Table" that doesn't provide an IRQ (Seems the 
irq of the IDE Controller, but all works correctly...) ) , but if I 
enable ACPI support with the IO APIC the system does not shutdown 
properly in the most of cases , and it reboots instead . Powering off 
the system by the Power Button does not work too.

I use the Linux Kernel 2.4.20 Version and the Debian "Sid" Distribution 
. I've tried the Debian kernel and the "vanilla" one, and both generates 
this error.

I'm lost , I don't know how to solve

Thanks

Bye

Marcello

