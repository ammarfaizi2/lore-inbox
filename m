Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132623AbRDOKrS>; Sun, 15 Apr 2001 06:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbRDOKrH>; Sun, 15 Apr 2001 06:47:07 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:11995 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132623AbRDOKq7>; Sun, 15 Apr 2001 06:46:59 -0400
Message-Id: <5.0.2.1.2.20010415114319.00b13350@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 15 Apr 2001 11:48:46 +0100
To: esr@thyrsus.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: CML2 1.1.0 bug and snailspeed
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010414135618.C10538@thyrsus.com>
In-Reply-To: <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk>
 <002601c0c4fb$c7e54260$0201a8c0@home>
 <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:56 14/04/2001, Eric S. Raymond wrote:
>Anton Altaparmakov <aia21@cus.cam.ac.uk>:
> > I found a bug: In "Intel and compatible 80x86 processor options", "Intel
> > and compatible 80x86 processor types" I press "y" on "Pentium Classic"
> > option and it activates Penitum-III as well as Pentium Classic options at
> > the same time!?! Tried to play around switching to something else and then
> > onto Pentium Classic again and it enabled Pentium Classic and Pentium
> > Pro/Celeron/Pentium II (NEW) this time! Something is very wrong here.
>
>Rules file bug, probably.  I'll investigate this afternoon.

Just to say that this bug still exists in CML2 1.1.1 but it is sometimes 
hidden, i.e. you only see a "Y" on one of the options but when you select 
another option, it sometimes says that TWO other options were set to "n" 
implying that two options were Y before... I also still see random two 
options being Y when playing with Pentium Classic selection (right now I 
see Pentium Classic and Pentium-4 at the same time being Y on my screen)...

Hope this helps,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

