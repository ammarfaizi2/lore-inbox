Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSK3OOV>; Sat, 30 Nov 2002 09:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbSK3OOU>; Sat, 30 Nov 2002 09:14:20 -0500
Received: from zeus.city.tvnet.hu ([195.38.100.182]:8320 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S265637AbSK3OOU>; Sat, 30 Nov 2002 09:14:20 -0500
Subject: module loading 2.5.50 + nvidia patch
From: Sipos Ferenc <sferi@mail.tvnet.hu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1038665822.1045.3.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-1) 
Date: 30 Nov 2002 15:17:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have compiled the kernel with make menuconfig, make bzImage, modules,
modules_install, and installed rusty's latest compatible modprobe util,
but moduls won't load, modprobe xx says modprobe.dep not found. With
insmod, I can load modules, but I'd like that the kernel do it
automatically such as in 2.4. In kernel config, the neccessary options
for this are set. What am I missing, or how has the kernel configuration
changed? By the way, does anybody has a working patch for the binary
3123 drivers? Thx.

Paco
