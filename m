Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbTGTK7m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 06:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266897AbTGTK7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 06:59:42 -0400
Received: from mail2.webmessenger.it ([193.70.193.55]:21182 "EHLO
	mail1c.webmessenger.it") by vger.kernel.org with ESMTP
	id S266896AbTGTK7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 06:59:41 -0400
From: Marco Bresciani <m.bresciani@email.it>
To: linux-kernel@vger.kernel.org, mec@shout.net
Subject: Kernel Configuration Error Reporting
Date: Sun, 20 Jul 2003 12:59:44 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307201259.44975.m.bresciani@email.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sirs,
    I was trying to use "make menuconfig" to configure my GNU/Linux kernel 
while the menu crashed at it appears this on the screen:

"  Menuconfig has encountered a possible error in one of the kernel's
   configuration files and is unable to continue. Her is the error
   report:

    Q> scripts/Menuconfig: line 832: MCmenu71: command not found

   Please report this to the mantainer <mec@shout.net>. You may also
   send a problem report to <linux-kernel@vger@kernel.org>.

   Please indicate the kernel version you are trying to configure and
   which menu you were trying to enter when this error occurred.

   make: [***] menuconfig Error 1   "

This is the error. I am trying to configure GNU/Linux Mandrake 9.1 kernel 
version 2.4.21-0.13mdk and this error appear when I try to enter the submenu 
"Advanced Linux Sound Architecture" inside the "Sound" menu.

Bye,

Marco Bresciani
