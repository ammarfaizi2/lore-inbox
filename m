Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSERNsL>; Sat, 18 May 2002 09:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSERNsK>; Sat, 18 May 2002 09:48:10 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:57105 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313122AbSERNsK>; Sat, 18 May 2002 09:48:10 -0400
Message-Id: <5.1.0.14.2.20020518144515.040cd480@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 18 May 2002 14:49:00 +0100
To: mikeH <mikeH@notnowlewis.co.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: linux 2.5.16 and VIA Chipset
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CE64D4D.4020508@notnowlewis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:47 18/05/02, mikeH wrote:
>Apologies, on closer examination of the 2.4 and 2.5 dmesg, it hangs just 
>before the
>ACPI is going to come up. However, there is no option for it in make 
>menuconfig, and enabling it in .config breaks the compile.

What do you mean there is no config option in menuconfig?!? I just checked 
and there is "General options" ---> "ACPI Support" ---> "[ ] ACPI Support".

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

