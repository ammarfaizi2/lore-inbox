Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVDPUPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVDPUPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 16:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVDPUPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 16:15:43 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:3798 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262747AbVDPUPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 16:15:36 -0400
Message-ID: <420333.1113682535160.JavaMail.root@pne-ps2-sn1>
Date: Sat, 16 Apr 2005 22:15:35 +0200 (MEST)
From: gabriel <gabriel.j@telia.com>
Reply-To: gabriel <gabriel.j@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Booting from USB with initrd
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [83.227.221.136]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Have you edit the build-initrd.sh script to fit your needs? 

Yeah.. but it shouldn't matter much since I've not been able to load the initrd 
yet?

>Does 
>  http://featherlinux.berlios.de/usb-instructions.htm or
>  http://www.ussg.iu.edu/hypermail/linux/kernel/0211.1/0551.html help?)

I thought the second one would so I changed the code (took a while to find 
the right place since I use 2.6 not 2.4) However that's a fix for a problem 
I don't have. My kernel never complains about root= bla it only says unable 
to mount on root fs.
I'm not sure what this tells us.

>Totally different Q's: 

>Have you called syslinux with the correct parameter to find your
>initrd.gz? 

I hope so. I have it setup up like in the loop-aes readme. Is there something special 
you have in mind?

>Do you have access to DOS bootable drive (To try to boot the kernel
>using loadlin from DOS command prompt. If that works you know that the
>issues are regarded to syslinux, if not - initrd/kernel) (?) 

Nope. I only have a knoppix and kanotix rescue disc to work off at the time 
=)

>Have you tried to boot kernel + initrd from your local linux
>installation?

No, I would if I knew how. Is there any howto for that?

Cheers.
