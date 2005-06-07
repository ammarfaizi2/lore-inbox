Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVFGQRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVFGQRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVFGQRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:17:50 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:43616 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261925AbVFGQRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:17:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=F0/0UZdo4ODZSXc8wy++ikxxgfRPFx0+f0qkefaJEgTzkwAjoWyt3nmLTKT7bSaJ6eFUXnqsiexUS+qACrohgTX0jBqypw0MeOsuT08M2fR/wXCBjQ+ObBUaVhMIKS077vt7UNR6hTKz3um5X1CqorPBKGYHUlggS4YQYN+8Sjc=
Message-ID: <42A5C8A3.2090202@gmail.com>
Date: Tue, 07 Jun 2005 18:17:39 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pentium-D support
References: <42A5B80A.4040709@tmr.com>
In-Reply-To: <42A5B80A.4040709@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen schrieb:

> Since this is really a question in several areas I'll put it here. Now
> that the Pentium-D processors are available at reasonable prices and
> for quick delivery, can anyone speak to the ACPI issues? The available
> boards use the 945 and 955 chipset. Is there any reason to think that
> the scheduler would get confused by the CPU, such as thinking it was
> HT or some such?

There are only issues with CPUFREQ/speedstep and some ACPI related
things on Intel 955X chipset I have. So I use a ASUS P5WD2-Premium.
The Pentium D will reach me in few days so I only guess and  I think the
kernel know how to handle Physical Cores and SMT/HT Processors.

>
> The specs indicate that 64 bit is supported, is there any actualy
> Linux support for the Intel 64 bit stuff in gcc and the kernel? One of
> the people I work with reports that the distro he runs on his Athlon64
> lock solid after reading the boot sector, so obviously this isn't
> Athlon compatable.
>
Yes the 64bit support of the Intel CPUs are well supported, I use a
Intel Pentium 4 640 and 64bit compiled system (Gentoo 2005)
I have no problems everything is working nearly perfect better as my
AMD64 system.

For GCC 3.4.x or 4.0.x you only need the compile switch -march=nocona as
the name of the XEON..but its the same piece of technologie

> The price is lower than a dual Xeon setup if you have an application
> which needs SMP, and initial power values make it look like a lower
> power solution overall.

Cheep and good performance.

Greets
Best regards
    Michael
