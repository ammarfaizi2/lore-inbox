Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319753AbSIMTCU>; Fri, 13 Sep 2002 15:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319754AbSIMTCU>; Fri, 13 Sep 2002 15:02:20 -0400
Received: from smtp.comcast.net ([24.153.64.2]:29695 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S319753AbSIMTCT>;
	Fri, 13 Sep 2002 15:02:19 -0400
Date: Fri, 13 Sep 2002 15:02:18 -0400
From: Adam Jaskiewicz <adamjaskie@comcast.net>
Subject: Re: Configuring kernel
In-reply-to: <20020913184715.62063.qmail@web13205.mail.yahoo.com>
To: Srinivas Chavva <chavvasrini@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Reply-to: adamjaskie@comcast.net
Message-id: <02091315021800.01433@aragorn>
MIME-version: 1.0
X-Mailer: KMail [version 1.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
References: <20020913184715.62063.qmail@web13205.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I downloaded the sofware and opened it in the /usr/src
> directory. I did the following
> 1. unzipped the tar file
> 2. mv linux linux-2.4.16
> 3 ln -s linux-2.4.16 linux
> 4. changed to linux directory and issued the command
> make mproper.
> Then when I issued the command make xconfig I was
> getting errors. I got similar errors when I tried to
> use the following commands make menuconfig, make
> config.

What errors did you get? We need to know what the errors are to help you.

> When I used the command uname -i I still was getting
> the kernel version as 2.4.2.
> I do not know why this error is coming.

This is not an error. If you did not install a new kernel and reboot your 
computer with the new kernel, uname will still have the same kernel version. 
Once you have properly configured, compiled and installed the kernel and its 
modules, you reboot the computer to apply the new kernel. Then uname will 
give you the new version.

-- 
Adam Jaskiewicz
adamjaskie@comcast.net
http://middlearth.d2g.com:31415
GPG Public Key at http://middlearth.d2g.com:31415/public_key.asc
--
Ehrman's Commentary:
	(1) Things will get worse before they get better.
	(2) Who said things would get better?
