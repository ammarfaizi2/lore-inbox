Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbSJQMkV>; Thu, 17 Oct 2002 08:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSJQMkV>; Thu, 17 Oct 2002 08:40:21 -0400
Received: from fep02.tuttopmi.it ([212.131.248.101]:27534 "EHLO
	fep02-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S261553AbSJQMkU> convert rfc822-to-8bit; Thu, 17 Oct 2002 08:40:20 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Frederik Nosi <fredi@e-salute.it>
Reply-To: fredi@e-salute.it
To: linux-kernel@vger.kernel.org
Subject: [BUG][neofb]2.5.4[0-3]
Date: Thu, 17 Oct 2002 14:49:12 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210171449.12222.fredi@e-salute.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a DELL Latitude CPi D233SP. With kernels from 2.5.40 to 2.5.43 using 
neofb during shutdown I get an Oops:

Danger danger! Oopsen imminent
MTRR setting reg 2

This is the second time I'm reporting this, the first time I CC'ed the 
mantainer too without results. Here is the link to my previous posting:

http://www.cs.helsinki.fi/linux/linux-kernel/2002-39/1108.html

With the 2.4.19/20-pre-last kernels scrolling up in the console is very slow 
using the neofb driver as I've wrote in my previous posting.


For more info please CC me.

