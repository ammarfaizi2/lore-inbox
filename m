Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270264AbRHRR6y>; Sat, 18 Aug 2001 13:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270270AbRHRR6o>; Sat, 18 Aug 2001 13:58:44 -0400
Received: from [209.38.98.99] ([209.38.98.99]:10201 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S270264AbRHRR6c>;
	Sat, 18 Aug 2001 13:58:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fred Jackson <fred@arkansaswebs.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.xx won't recompile.
Date: Sat, 18 Aug 2001 12:57:00 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081812570001.09229@bits.linuxball>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi ya,

I have a Redhat 7.1 system practically out of the box, and though I 
had no problem compiling 2.4.9 the first time around, I can't 
recompile it at all without deleting the directory and untaring the 
distribution again. 

any ideas?

thanks in advance!

Fred

I start with the usual 
make mrproper
make xconfig ( I load a kernel config file - originally created with 
2.4.8) 
make bzImage
make modules
make modules_install
make install

(i've already edited lilo.conf and the links in the /boot directory)

