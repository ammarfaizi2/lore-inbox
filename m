Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTAJLlU>; Fri, 10 Jan 2003 06:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbTAJLlT>; Fri, 10 Jan 2003 06:41:19 -0500
Received: from web13106.mail.yahoo.com ([216.136.174.151]:6513 "HELO
	web13106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262208AbTAJLlP>; Fri, 10 Jan 2003 06:41:15 -0500
Message-ID: <20030110114959.60150.qmail@web13106.mail.yahoo.com>
Date: Fri, 10 Jan 2003 12:49:59 +0100 (CET)
From: =?iso-8859-1?q?Ole=20Jacob=20Hagen?= <olehag_2001@yahoo.no>
Subject: Unable to boot kernel-2.5.50 to kernel-2.5.55
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This might be wrong mailinglist, but I don't know else
to to.

I am having a Dell Optiplex GX240, 512 MB RAM, ATI
RAGE 128. I am using Gentoo GNU/Linux. 

I have installed module-init-tools-0.9.7. 
I have difficulties in booting development kernels.
I am using GRUB as boot-loader, and can choose between
different kernel-2.4 series and kernel-2.5.  

I am passing root=/dev/hda3 to all kernels. 

My screen turns black and the computer reboots, when I
try to boot a development kernel. 
I havent't applied Rusty's patch for PCI and USB,
because I thought it was for kernel-2.5.50. Is it
necessary? 

I'm using pretty much the same config-file in
kernel-2.5 as in kernel-2.4. I have tried to disable
all framebuffer support, but nothing happened. 

Should I try another version of GRUB?

How should the config-file for kernel-2.5.5x look
like? 

I am trying out development kernels, because I like
being in bleeding edge, when it comes to computers. 
Have to challenge myself...:-)

Cheers, 

Ole J. 
 


______________________________________________________
Få den nye Yahoo! Messenger på http://no.messenger.yahoo.com/
Nye ikoner og bakgrunner, webkamera med superkvalitet og dobbelt så morsom
