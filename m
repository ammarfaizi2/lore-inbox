Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbTAPCmO>; Wed, 15 Jan 2003 21:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbTAPCmO>; Wed, 15 Jan 2003 21:42:14 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:29396 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266514AbTAPCmN>; Wed, 15 Jan 2003 21:42:13 -0500
Date: Thu, 16 Jan 2003 15:50:49 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Valdis.Kletnieks@vt.edu
cc: Mikael Pettersson <mikpe@csd.uu.se>, voytech@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42 
Message-ID: <3660000.1042685449@localhost.localdomain>
In-Reply-To: <200301151921.h0FJLvV0009887@turing-police.cc.vt.edu>
References: <15909.13901.284523.220804@harpo.it.uu.se>           
 <481480000.1042627438@localhost.localdomain>
 <200301151921.h0FJLvV0009887@turing-police.cc.vt.edu>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The i8k will power off with APM but not ACPI, but it won't reboot with 
either.

I'm using grub, so it may hit the problem before outputting anything where 
lilo may not.

Andrew

--On Wednesday, January 15, 2003 14:21:57 -0500 Valdis.Kletnieks@vt.edu 
wrote:

> On Wed, 15 Jan 2003 23:43:58 +1300, Andrew McGregor said:
>> Possibly related:
>>
>> Dell Inspiron 8000s won't warm reboot either.  They just freeze with a
>> blinking cursor at the point where the bootloader would ordinarily load.
>> Have to power off or reset.
>>
>> Consistent in various versions from 2.5.44 to .55.  Have not tested
>> earlier, nor yet later.
>
> Dell Latitude C840s will power off.  Oddly enough, it doesn't do it when
> LILO itself loads - it does it when LILO starts loading the actual kernel
> image.  True from 2.5.46 through 2.5.58.
> --
> 				Valdis Kletnieks
> 				Computer Systems Senior Engineer
> 				Virginia Tech
>


