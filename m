Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313276AbSC1Wwd>; Thu, 28 Mar 2002 17:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313277AbSC1WwX>; Thu, 28 Mar 2002 17:52:23 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:41468 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313276AbSC1WwE>; Thu, 28 Mar 2002 17:52:04 -0500
Date: Thu, 28 Mar 2002 22:52:03 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Christian Schoenebeck <christian.schoenebeck@epost.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: power off
In-Reply-To: <20020328214032.4F55147B1@debian.heim.lan>
Message-ID: <Pine.SOL.3.96.1020328224816.4244A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You mell well find that you just need to upgrade your userspace utilities
to make it work. For me, using the exact same kernel!!! but a different
distro makes the difference between the computer just sitting there when I
shutdown -h now or actually powering off...

In this particular case I just moved from SuSE 7.2 to Mandrake 8.1 and
suddenly poweroff worked. (Note I used my custom kernel in both cases
which I just copied from the old install onto the new one.)

Having said all that some versions of 2.4 kernels have broken shutdown so
it would help if you said which kernel version you are using...

Cheers,

Anton


On Thu, 28 Mar 2002, Christian Schoenebeck wrote:

> (please cc me)
> 
> Hi everybody!
> 
> I've got a problem with a machine (using an Asus SP98AGP-X mainboard) that 
> doesn't want to power off since moving from 2.2.x to 2.4.x kernel. As I 
> haven't found any other solution, can I simply replace the new apm.c by the 
> old one from 2.2.x or just a part of the unit or would that be fatal?
> 
> PLEASE HELP ME WITH THIS!
> 
> Thanks in advance,
> 
> Christian Schoenebeck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

