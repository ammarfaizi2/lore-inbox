Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbUKEMm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUKEMm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbUKEMm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:42:57 -0500
Received: from alog0291.analogic.com ([208.224.222.67]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262665AbUKEMmz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:42:55 -0500
Date: Fri, 5 Nov 2004 07:41:35 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Giuseppe Bilotta <bilotta78@hotpop.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.9 won't allow a write to a NTFS file-system. 
In-Reply-To: <200411050146.iA51kFmB004582@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.61.0411050738400.12058@chaos.analogic.com>
References: <200411050146.iA51kFmB004582@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Horst von Brand wrote:

> linux-os <linux-os@chaos.analogic.com> said:
>
> [...]
>
>> Huh? Are we talking about the same thing? I'm talking about
>> the NTFS that Windows/NT and later versions puts on its
>> file-systems. I use an USB external disk with my M$ Laptop
>> and I have always been able to transfer data to/from
>> my machines using that drive. Now I can't. The drive it
>> writable under M$, but I can't even delete anything
>> (no permission for root) under Linux.
>
> Looks like you reformated from the original VFAT (== Win9x) to NTFS.
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
>

The plot thickens. My 2.4.x system had the ntfs.sys adapter module.
I just re-partitioned and re-formatted the drive to FAT-32.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
