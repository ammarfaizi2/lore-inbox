Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSERSkv>; Sat, 18 May 2002 14:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSERSku>; Sat, 18 May 2002 14:40:50 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:55575 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313698AbSERSku>; Sat, 18 May 2002 14:40:50 -0400
Message-Id: <5.1.0.14.2.20020518192409.0402a7b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 18 May 2002 19:39:48 +0100
To: mikeH <mikeH@notnowlewis.co.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: linux 2.5.16 and VIA Chipset
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3CE697B1.7040904@notnowlewis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:04 18/05/02, mikeH wrote:
>Anton Altaparmakov wrote:
>>>I havent done anything like copying the old .config from my 2.4 series 
>>>kernel, this was a clean
>>>tar jxvf linux-2.5.16.tar.bz2 && cd linux-2.5.16 && make menuconfig
>>
>>hm. try a make mrproper
>>
>>and then a make menuconfig
>
>Tried that, still nothing. I'll try downloading the patch and patching it 
>against 2.4.18.

Huh? There are no patches to go from 2.4.18 to 2.5.anything AFAIK.

I just downloaded linux-2.5.16.tar.bz2 from kernel.org, did tar xvjf, cd, 
make mrproper, make menuconfig, enabled config experimental, and I get the 
ACPI option so something is wrong on your end... This is on ia32 arch.

Which architecture are you using?

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

