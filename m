Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266024AbTGDMuC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 08:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbTGDMuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 08:50:02 -0400
Received: from 62-15-228-129.es.jazztelbone.net ([62.15.228.129]:49386 "EHLO
	titan.gesline.com") by vger.kernel.org with ESMTP id S266024AbTGDMuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 08:50:00 -0400
From: =?iso-8859-1?q?V=EDctor=20Romero?= <victor.romero@gesline.com>
Organization: Gesline
To: linux-kernel@vger.kernel.org
Subject: console=tty2
Date: Fri, 4 Jul 2003 15:04:24 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307041504.24844.victor.romero@gesline.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	Dear kernel hackers,

	In a little appliance (i386) I'm working on I have a linux(2.4.20 vanilla) 
booting with a pretty nice logo in fb mode, but I dont want to see text in 
the boot process just the logo, so I tryed on boot : linux console=tty2, but 
still see everything, If i put to ttyS0 works but I have a modem there,so its 
not a good idea, anyway tty2 should work, but it doesnt, any idea?

	I can't use bootsplash because the initrd image I need its already too big 
and actually I prefer to use just the vanilla kernel.

	Can be redirected to /dev/null the console? I know this its not a good idea 
but, I can have to lilo entrys the first one with console=tty and the other 
one with console=null?

	Greetings

