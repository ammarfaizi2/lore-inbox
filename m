Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSLGVKg>; Sat, 7 Dec 2002 16:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbSLGVKg>; Sat, 7 Dec 2002 16:10:36 -0500
Received: from zeus.city.tvnet.hu ([195.38.100.182]:8576 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S264756AbSLGVKg>; Sat, 7 Dec 2002 16:10:36 -0500
Subject: kernel or distro bug?
From: Sipos Ferenc <sferi@mail.tvnet.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1039295986.1486.4.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-1) 
Date: 07 Dec 2002 22:19:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm using rh8 as a default distro. I've compiled 2.4.19 stock kernel,
everything works fine. With the same config options, I've compiled
2.4.20, but when I reboot the machine with the new kernel, the boot
process stops at starting iptables line, and nothing happens. When I
remove the iptables daemon with chkconfig, system boots fine, and when I
start the daemon by hand, it works. Neither 2.4.19 nore 2.5.50 has a
problem with the iptables daemon during startup. Has anybody met the
above situation? 

Paco
