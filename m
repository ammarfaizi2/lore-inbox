Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131473AbRCQAJ2>; Fri, 16 Mar 2001 19:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131440AbRCQAJS>; Fri, 16 Mar 2001 19:09:18 -0500
Received: from dns1.rz.fh-heilbronn.de ([141.7.1.18]:57487 "EHLO
	dns1.rz.fh-heilbronn.de") by vger.kernel.org with ESMTP
	id <S131457AbRCQAJH>; Fri, 16 Mar 2001 19:09:07 -0500
Date: Sat, 17 Mar 2001 01:08:19 +0100 (CET)
From: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
Reply-To: Oliver Paukstadt <oliver@paukstadt.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: observations with asus cuv4x-d
Message-ID: <Pine.LNX.4.05.10103170101410.13178-100000@lara.stud.fh-heilbronn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HY HY

I changed my motherboard to a asus cuv4x-d with 2 PIII-800.

With MPS 1.4 enabled (BIOS), i'll get 
probable hardware bug: clock timer configuration lost - probably a VIA686a
motherboard (linux/arch/i386/kernel/time.c)
I use 2.4.2-ac20

Disabling MPS1.4 causes the Board to work without any problems.

BYtE Oli

+++LINUX++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++Manchmal stehe ich sogar nachts auf und installiere mir eins....+++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 



