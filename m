Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312762AbSCVRDK>; Fri, 22 Mar 2002 12:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312760AbSCVRDB>; Fri, 22 Mar 2002 12:03:01 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:56843 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S312759AbSCVRCs>;
	Fri, 22 Mar 2002 12:02:48 -0500
Mailbox-Line: From tmh@nothing-on.tv  Fri Mar 22 17:02:44 2002
Mailbox-Line: From tmh@nothing-on.tv  Fri Mar 22 17:02:39 2002
From: tmh@nothing-on.tv (Tony Hoyle)
Subject: Re: Kernel Upgrade Hangs!
Date: Fri, 22 Mar 2002 17:02:42 GMT
Organization: cvsnt.org news server
Message-ID: <3c9b634e.83969781@news.cvsnt.org>
In-Reply-To: <91A7E7FABAF3D511824900B0D0F95D10136FA4@BHISHMA>
X-Trace: sisko.my.home 1016816558 4428 193.37.229.181 (22 Mar 2002 17:02:38 GMT)
X-Complaints-To: abuse@cvsnt.org
X-Newsreader: Forte Free Agent 1.21/32.243
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002 16:22:32 +0000 (UTC), Abdij Bhat
<Abdij.Bhat@kshema.com> wrote:

>>
> Now when i reboot and select the linux-Mine option the screen displays
>		Loading vmlinuz-2.4.7
>		Uncompressing Linux... Ok, booting the kernel

You aren't booting 2.4.17, so it's not the kernel that's the problem.
There's probably a way on your distro to switch kernels (it used to be
/etc/lilo.conf with all the modern GUI stuff it could be anywhere).

Tony

