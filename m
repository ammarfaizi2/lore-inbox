Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUIEEKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUIEEKE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 00:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUIEEKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 00:10:04 -0400
Received: from lakermmtao04.cox.net ([68.230.240.35]:35822 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S265823AbUIEEJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 00:09:59 -0400
In-Reply-To: <1094316425.10555.32.camel@localhost.localdomain>
References: <1B6CEB06-FE2B-11D8-B9BD-000393ACC76E@mac.com> <1094316425.10555.32.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6E58E82C-FEF1-11D8-82A2-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.4.25] "pc_keyb: controller jammed (0xFF)" on Super Micro	P5MMA98
Date: Sun, 5 Sep 2004 00:09:49 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 04, 2004, at 12:47, Alan Cox wrote:
> On Sad, 2004-09-04 at 05:30, Kyle Moffett wrote:
>> I have a Super Micro P5MMA98 motherboard that does not recognize
>> the PS/2 keyboard controller under Debian.  It repeatedly gives errors
>> like the
>
> Go into the BIOS, disable "USB legacy" support. Retest. If that fixes 
> it
> then look for a BIOS update and/or complain to your board vendor as
> appropriate. If not come back here

I've already tried both settings for "USB legacy", neither work.  I'm
currently attempting to update the BIOS. The update I tried a couple
weeks ago didn't work and gave an error, but there appears to be a new
one out, so I'm trying that.  Is there anything else that it could be?  
What
exactly does the keyboard code check when it generates that error?

Thanks for your help!

Version: Stock Debian 2.4.25-1-386
Dmesg: http://www.tjhsst.edu/~kmoffett/dmesg.txt
Config: http://www.tjhsst.edu/~kmoffett/config-2.4.25-1-386.txt

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


